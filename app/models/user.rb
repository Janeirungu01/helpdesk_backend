class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :jwt_jti
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtAllowlist
      

  before_create :set_initial_jti
  has_many :notifications
  has_many :tickets

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions.to_h).where(["lower(username) = :value", { value: username.downcase }]).first
    end
  end

  private

  def set_initial_jti
    self.jwt_jti = SecureRandom.uuid
  end
end
