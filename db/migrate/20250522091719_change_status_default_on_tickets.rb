class ChangeStatusDefaultOnTickets < ActiveRecord::Migration[8.0]
  def change
    change_column_default :tickets, :status, "open"
    change_column_null :tickets, :status, false
  end
end
