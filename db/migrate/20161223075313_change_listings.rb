class ChangeListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :created_at, :datetime, null: false
  	add_column :listings, :updated_at, :datetime, null: false
  end
end
