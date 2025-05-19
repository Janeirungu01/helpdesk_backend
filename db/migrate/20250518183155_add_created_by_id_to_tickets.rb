class AddCreatedByIdToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :created_by_id, :integer
  end
end
