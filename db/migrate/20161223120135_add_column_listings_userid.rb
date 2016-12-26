class AddColumnListingsUserid < ActiveRecord::Migration[5.0]
  def change
  	add_reference :listings, :user, index: true
  end
end
