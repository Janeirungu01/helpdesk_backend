class RefreshToken < ApplicationRecord
  belongs_to :user

  before_create :generate_token_and_expiry

  def expired?
    Time.current > expires_at
  end

  private

  def generate_token_and_expiry
    self.token = SecureRandom.hex(64)
    self.expires_at = 7.days.from_now
  end
end
