class ChangeTableListings < ActiveRecord::Migration[5.0]
  def change
  	remove_column :listings, :availabilty
  	add_column :listings, :availability_start, :date
  	add_column :listings, :availability_end, :date
  end
end
