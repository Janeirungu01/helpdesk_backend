class RefreshTokensController < ApplicationController
  # skip_before_action :authenticate_user!  # Bypass regular JWT auth

  # def create
  #   refresh_token = params[:refresh_token]
  #   record = JWTAllowlist.find_by(jti: refresh_token)

  #   if record && record.user && !record.expired?
  #     # Revoke old tokens (optional)
  #     record.destroy
      
  #     # Issue new tokens
  #     new_access_token = record.user.generate_jwt
  #     new_refresh_token = SecureRandom.uuid

  #     JWTAllowlist.create!(
  #       jti: new_refresh_token,
  #       user: record.user,
  #       exp: 7.days.from_now
  #     )

  #     render json: {
  #       access_token: new_access_token,
  #       refresh_token: new_refresh_token,
  #       expires_in: 15.minutes
  #     }, status: :ok
  #   else
  #     render json: { error: "Invalid or expired refresh token" }, status: :unauthorized
  #   end
  # end
end