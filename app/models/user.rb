class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
  	create! do |u|
  		u.email = auth_hash["extra"]["raw_info"]["email"]
  		u.authentications << (authentication)
      u.encrypted_password = SecureRandom.hex(3)
  	end
  end

  def fb_token
  	x = self.authentications.where(:provider => :facebook).first
  	return x.token unless x.nil?
  end

  def password_optional?
  	true
  end

end
