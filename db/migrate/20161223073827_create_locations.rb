class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
    	t.string :address
    	t.string :state
    	t.string :city
    	t.string :country
    	t.timestamps null: false
    	t.belongs_to :listing, index: true
    end
  end
end
