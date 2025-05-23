# class AddRoleToUsers < ActiveRecord::Migration[8.0]
#   def change
#     add_column :users, :role, :integer, default: 0, null: false
#   end
# end

class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:users, :role)
      add_column :users, :role, :integer, default: 0, null: false
    end
  end
end
