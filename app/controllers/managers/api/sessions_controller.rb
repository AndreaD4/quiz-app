module Managers
  class Api::SessionsController < Api::ApplicationController
    #skip_before_action :require_login!, only: [:create]

    def create
      company = Company.first
      resource = Manager.find_for_database_authentication(:email => params[:manager_login][:email], host: company.host)
      return invalid_login_attempt unless resource

      if resource.valid_password?(params[:manager_login][:password])
        resource.generate_auth_token

        if params[:device].present?
          @device = company.devices.find_or_initialize_by(device_id: params[:device][:device_id])
          @device.manager_id = resource.id
          @device.device_name = params[:device][:device_name]
          @device.token = params[:device][:token]
          @device.platform = params[:device][:platform]
          @device.app_version = params[:device][:app_version]
          @device.pda = params[:device][:pda]
          @device.last_sign_in = Time.now
          @device.last_sign_out = nil

          if @device.save
            @device.update(pda: "PDA#{@device.progr.to_s.rjust(2, "0")}")
          end

          if params[:manager_login][:version_app].present?
            @version_app = params[:manager_login][:version_app]
          end

        end
        @manager = resource

        json_company = {
          id: company.id,
          name: company.name,
          host: request.host
        }

        render json: { company: json_company, id: resource.id, first_name: resource.first_name, last_name: resource.last_name, email: resource.email, auth_token: resource.auth_token, company_id: resource.company_id, cod_pda: @device.pda }
      else
        invalid_login_attempt
      end

    end

    def companies
      super
    end

    def destroy
      resource = current_manager
      resource.invalidate_auth_token
      # if params[:device].present?
      #   @device = current_company.devices.find_or_initialize_by(device_id: params[:device][:device_id])
      #   @device.last_sign_out = Time.now
      #   @device.save
      # end
      head :ok
    end

    def ping
      render json: { response: 'pong' }
    end

    private

    def invalid_login_attempt
      render json: { errors: [{ detail: 'Password non valida.' }] }, status: 401
    end
  end
end