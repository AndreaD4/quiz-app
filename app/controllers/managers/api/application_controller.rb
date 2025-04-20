module Managers
  class Api::ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    # before_action :redirect_url?

    # before_action :require_login!, except: [:companies]
    before_action :app_authenticate, only: [:companies]

    helper_method :manager_signed_in?, :current_manager

    respond_to :json

    def companies
      manager_companies = []

      if params[:manager_email]
        companies = Company.joins(:managers).where('managers.email = ?', params[:manager_email])

        companies.each do |c|
          company = {}
          company[:id] = c.id
          company[:host] = c.host
          company[:name] = c.name
          manager_companies << company
        end

      end

      render json: {companies: manager_companies}, status: 200
    end

    def current_company
      # unless resource.is_a? Admin
      # @company ||= Company.find_by_host(request.host) or not_found
      @company ||= Company.first or not_found
      # end
    end

    def manager_signed_in?
      @current_manager.present?
    end

    def require_login!
      return true if authenticate_token
      # return true if params[:controller] == 'managers/api/v1/waste_works' and params[:action] == 'get_work'

      render json: {errors: [{detail: 'Access denied'}]}, status: 401
    end

    def current_manager
      @current_manager ||= authenticate_token
    end

    # def redirect_url?
    #   company = Company.find_by_host(request.host)
    #
    #   redirect_url = nil
    #   if company.nil? and (request.host.include?('e-portal.it') or request.host.include?('e-water.it'))
    #     redirect_url = request.original_url.gsub('e-portal.it', 'k-portal.it').gsub('e-water.it', 'k-portal.it')
    #   end
    #
    #   if redirect_url.present?
    #     redirect_to redirect_url
    #   end
    # end

    private

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        Manager.where(auth_token: token).where(company_id: current_company.id).where('token_created_at >= ?', 1.month.ago).first
      end
    end

    def app_authenticate
      app_authenticate_token || render_unauthorized
    end

    def app_authenticate_token
      authenticate_with_http_token do |token, options|
        true
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="e-portal"'
      render json: 'Bad credentials', status: 401
    end

  end
end