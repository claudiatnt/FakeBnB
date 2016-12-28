class User < ApplicationRecord
  include Clearance::User

  enum role: [ :master, :admin, :user ]
  after_initialize :set_default_role, :if => :new_record?

  has_many :authentications, :dependent => :destroy
  has_many :listings

  def self.create_with_auth_and_hash(authentication, auth_hash)
  	create! do |u|
  		u.email = auth_hash["extra"]["raw_info"]["email"]
      u.gender = auth_hash["extra"]["raw_info"]["gender"]
      u.age = auth_hash["extra"]["raw_info"]["birthday"]
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

  def set_default_role
    self.role ||= :user
  end

end
