class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    redirect_to root_path
  end

  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

    protected
      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) << :name
        devise_parameter_sanitizer.for(:sign_in) << :name
        devise_parameter_sanitizer.for(:account_update) << :name << :image << :profile << :remove_image
      end
end