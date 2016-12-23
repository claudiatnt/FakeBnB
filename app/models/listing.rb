class Listing < ApplicationRecord
	has_many :taggings
	has_many :tags, :through => :taggings
	has_many :locations

	accept_nested_attributes_for :locations

end