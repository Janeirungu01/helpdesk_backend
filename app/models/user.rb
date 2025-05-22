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
  has_many :refresh_tokens, dependent: :destroy

  USER_TYPES = {agent: 'Agent', admin: 'Admin', client: 'Client'}.freeze

  validates :usertype, inclusion: { in: USER_TYPES.values }
  after_initialize :set_default_user_type, if: :new_record?

  # Helper methods
  def admin?
    user_type == USER_TYPES[:admin]
  end

  def agent?
    user_type == USER_TYPES[:agent]
  end

  private

  def set_default_user_type
    self.user_type ||= USER_TYPES[:agent]
  end  


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions.to_h).where(["lower(username) = ?", username.downcase]).first
    else
      where(conditions.to_h).first
    end
  end
end
