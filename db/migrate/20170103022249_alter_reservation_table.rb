class AlterReservationTable < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :transaction, :integer, default: 0
  end
end
