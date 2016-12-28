class Listing < ApplicationRecord

	enum verification: [:unverified, :verified]

	has_many :taggings
	has_many :tags, :through => :taggings
	belongs_to :user

	# scope :page, Proc.new {|num|
	# 	limit(default_per_page).offset(default_per_page * ([num.to_i, 1] - 1))
	# }

end