require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

	let (:listing1){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }
	let (:listing2){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }
	let (:listing3){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }
	let (:listing4){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }
	let (:listing5){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }
	let (:listing6){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }

	describe "#index" do

	end

end