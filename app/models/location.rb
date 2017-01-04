class Location < ApplicationRecord
	include PgSearch
	# Scopes
	pg_search_scope :city, :against => :city, :using => { :tsearch => { :prefix => true, :dictionary => "english" } }
	pg_search_scope :state, :against => :state, :using => { :tsearch => { :prefix => true, :dictionary => "english" } }
	pg_search_scope :country, :against => :country, :using => { :tsearch => { :prefic => true, :dictionary => "english" } }

	belongs_to :listing

end