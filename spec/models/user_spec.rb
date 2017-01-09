require 'rails_helper'

RSpec.describe User, type: :model do
	it "should have name and email and password_digest" do
      should have_db_column(:email).of_type(:string)
      should have_db_column(:encrypted_password).of_type(:string)
      should have_db_column(:gender).of_type(:string)
    end
end