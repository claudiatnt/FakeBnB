class AddIndexTaggingsAndTags < ActiveRecord::Migration[5.0]
  def change
    add_index :taggings, [:listing_id, :tag_id]
    add_index :tags, :tag_name, name: "index_tags_on_tag_name", using: 'btree'

  end
end
