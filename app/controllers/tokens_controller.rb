class TokensController < ApplicationController
  def refresh
    refresh_token = RefreshToken.find_by(token: params[:refresh_token])

    if refresh_token&.expired?
      render json: { error: 'Refresh token expired' }, status: :unauthorized
    elsif refresh_token
      # Issue new JWT
      jwt = Warden::JWTAuth::UserEncoder.new.call(refresh_token.user, :user, nil)
      render json: { access_token: jwt[0] }
    else
      render json: { error: 'Invalid refresh token' }, status: :unauthorized
    end
  end
end

