class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         jwt_revocation_strategy: JwtDenylist 

  has_many :notifications
  has_many :tickets

  # enum role: { admin: 0, agent: 1, user: 2 }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions.to_h).where(["lower(username) = ?", username.downcase]).first
    else
      where(conditions.to_h).first
    end
  end
end
