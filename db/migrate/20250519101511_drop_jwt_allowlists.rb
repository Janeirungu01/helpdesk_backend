class DropJwtAllowlists < ActiveRecord::Migration[8.0]
  def change
     drop_table :jwt_allowlists
  end
end
