class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
	rescue_from ::NameError, with: :error_occurred
	rescue_from ::ActionController::RoutingError, with: :error_occurred
	rescue_from ::Exception, with: :error_occurred

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

	def record_not_found(exception)
	  render json: {error: exception.message}.to_json, status: 404
	  return
	end

	def error_occurred(exception)
	  render json: {error: exception.message}.to_json, status: 500
	  return
	end

end
