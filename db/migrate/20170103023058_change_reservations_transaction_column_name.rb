class ChangeReservationsTransactionColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :reservations, :transaction, :payment_status
  end
end
