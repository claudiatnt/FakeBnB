require 'rails_helper'

RSpec.describe Listing, type: :model do
	let (:user) { User.new(email: "testing@gmail.com", password: "testing1234", age: 1992, gender: "male") }
	let (:listing1){ Listing.new(title: "New Listing", description: "Testing out my listing", rules: "No kids", bedroom: 4, bathroom: 4, price: 5000) }

	it "returns a Listing object" do
		expect(listing1).to be_a_kind_of Listing
	end

	it "returns a title" do
		expect(listing1.title).to eq("New Listing")
	end

	it "returns nothing" do
		expect(Listing.bedrooms(5)).to eq([])
	end

	it "returns something" do
		listing1.save
		expect(Listing.bedrooms(3).last).to eq(listing1)
	end

end