class UpdateJwtAllowlistStructure < ActiveRecord::Migration[8.0]
  def change
    change_column_null :jwt_allowlists, :jti, false
    change_column_null :jwt_allowlists, :exp, false
    change_column_null :jwt_allowlists, :aud, false
   
    remove_index :jwt_allowlists, :jti if index_exists?(:jwt_allowlists, :jti)
    add_index :jwt_allowlists, :jti, unique: true
  end
end
