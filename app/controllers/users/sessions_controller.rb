# class Users::SessionsController < Devise::SessionsController 
#   include ActionController::MimeResponds
#   respond_to :json

#   skip_before_action :verify_signed_out_user, only: :destroy

#   def create
#     self.resource = warden.authenticate!(auth_options)
#     sign_in(resource_name, resource)
    
#     # Get the JWT token
#     token = request.env['warden-jwt_auth.token']
    
#     # Set the Authorization header
#     response.headers['Authorization'] = "Bearer #{token}"

#     render json: {
#       message: "Signed in successfully",
#       token: token,  # Optional: Also return in response body
#       user: resource
#     }, status: :ok
#   end

#   def destroy
#     sign_out(resource_name)
#     render json: { message: "Signed out" }, status: :ok

#   end

#   protected

#   def respond_to_on_destroy
#     render json: { message: "Signed out" }, status: :ok
#   end
# end


class Users::SessionsController < Devise::SessionsController 
  include ActionController::MimeResponds
  respond_to :json

  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    # Get JWT from devise-jwt
    token = request.env['warden-jwt_auth.token']

    # Create refresh token
    refresh_token = resource.refresh_tokens.create

    # Set headers
    response.headers['Authorization'] = "Bearer #{token}"
    response.set_header('X-Refresh-Token', refresh_token.token)

    render json: {
      message: "Signed in successfully",
      token: token,
      refresh_token: refresh_token.token,
      user: resource
    }, status: :ok
  end

  def destroy
    # clean up refresh tokens
    current_user&.refresh_tokens&.delete_all if current_user
    sign_out(resource_name)
    render json: { message: "Signed out" }, status: :ok
  end

  protected

  def respond_to_on_destroy
    render json: { message: "Signed out" }, status: :ok
  end
end
