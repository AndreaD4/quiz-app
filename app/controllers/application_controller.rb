class ApplicationController < ActionController::Base
  layout :layout_by_resource
  helper_method :current_company

  def current_company
    @company ||= Company.find_by_host(request.host) or not_found
  end

  def after_sign_in_path_for(resource)
    case resource
    when User
      root_path
    when Manager
      manager_root_path
    else
      not_found
    end
  end

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def user_not_authorized
    flash[:alert] = t('misc.access_denied')
    redirect_to(params[:redirect_url] || request.referrer || root_path)
  end

  def layout_by_resource
    if devise_controller?
      'auth'
    else
      'application'
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
    when :user
      new_user_session_path
    when :manager
      new_manager_session_path
    else
      root_path
    end
  end

end
