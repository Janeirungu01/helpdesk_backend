class ChangeDepartmentToReferenceInTickets < ActiveRecord::Migration[8.0]
  def change
    remove_column :tickets, :department, :string
    add_reference :tickets, :department, foreign_key: true
  end
end
