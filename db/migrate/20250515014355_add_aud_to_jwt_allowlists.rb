class AddAudToJwtAllowlists < ActiveRecord::Migration[8.0]
  def change
    add_column :jwt_allowlists, :aud, :string
  end
end
