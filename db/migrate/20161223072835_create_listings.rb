class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.string :title
    	t.string :description
    	t.string :rules
    	t.date :availabilty
    	t.integer :bedroom
    	t.integer :bathroom
    	t.integer :price
    end
  end
end
