class AddFieldsToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :category, :string
    add_column :tickets, :branch, :string
  end
end
