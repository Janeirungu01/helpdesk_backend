class ApplicationController < ActionController::API
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :log_authorization_header
  
  before_action do
    puts "Format: #{request.format}, Content-Type: #{request.content_type}"
    puts "Authorization: #{request.headers['Authorization']}"
  end

  def log_authorization_header
    Rails.logger.debug "Authorization Header: #{request.headers['Authorization']}"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :full_name, :usertype, branches: []])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_name, :usertype, branches: []])
  end

end

