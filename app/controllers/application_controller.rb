class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :country, :email, :role, :password, :password_confirmation, :policy)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :country, :password, :current_password, :policy)}
    end

    def after_sign_in_path_for(resource)
      if current_user.has_role? :client
        client_posts_path
      elsif current_user.has_role? :freelancer
        new_profile_path
      end
    end
end