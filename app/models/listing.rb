class Listing < ApplicationRecord
include PgSearch
	# Scopes
	scope :above, ->(price){ where("price > ?", price) }
	scope :below, ->(price){ where("price < ?", price) }
	scope :bedrooms, ->(number){ where("bedroom >= ?", number)  }
	scope :bathrooms, ->(number) { where("bathroom >=?", number) }
	scope :latest, ->(empty) { order("created_at DESC") }
	scope :oldest, ->(empty) { order("created_at ASC") }
	pg_search_scope :description, :against => :description, :using => { :tsearch => {:prefix => true, :dictionary => "english" } }
	pg_search_scope :rules, :against => :rules, :using => { :tsearch => {:prefix => true, :dictionary => "english" } }
	pg_search_scope :city, :associated_against => {:locations => :city }, :using => { :tsearch => { :prefix => true, :dictionary => "english" } }

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

	# Search method original withtout scope-----------------------
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

	 def self.filter(params)
    results = self.where(nil)
    if params["/listings"].present? && params["/listings"][:query_target] != ""
    	method = params["/listings"][:query_target]
    	argument = params["/listings"][:query]
    	results = results.public_send(method.downcase.to_s, argument)
  	end
    results
  end

end