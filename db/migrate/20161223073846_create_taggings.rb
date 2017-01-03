class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
    	t.belongs_to :listing
    	t.belongs_to :tag
    end
  end
end
