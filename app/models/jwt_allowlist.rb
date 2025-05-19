class JwtAllowlist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

  self.table_name = 'jwt_allowlists'

  belongs_to :user
end
