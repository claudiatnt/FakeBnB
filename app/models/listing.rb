class Listing < ApplicationRecord

# Enum roles
	enum verification: [:unverified, :verified]

# Associations-------------------------
	has_many :taggings
	has_many :tags, :through => :taggings
	belongs_to :user
	has_many :reservations
	has_many :locations
# -------------------------------------

	# Carrierwave
	mount_uploaders :photos, PhotoUploader

	# Search method-----------------------
	def self.search(search, target)
		if search
			if target == "City"
				search_for_location(search, target)
			elsif target == "Show All"
				Listing.all
			end
		else
			Listing.all
		end
	end

	def self.search_for_location(search, target)
		result = []
		Listing.all.each do |listing|
			result << listing.locations.where("#{target.downcase}": search)
		end
		result.flatten.map{|location| location.listing}
	end

	# ------------------------------------
end