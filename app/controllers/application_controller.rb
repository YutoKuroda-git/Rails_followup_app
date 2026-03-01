class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  ActionView::Base.field_error_proc = proc { |html_tag, _instance| html_tag }

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    customers_path
  end

  def restrict_guest!
    if current_user.guest?
      redirect_back fallback_location: customers_path, alert: "ゲストユーザーはこの操作はできません"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
