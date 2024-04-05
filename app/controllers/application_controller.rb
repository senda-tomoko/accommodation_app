class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Deviseのログアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :self_introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :self_introduction])
  end
end
