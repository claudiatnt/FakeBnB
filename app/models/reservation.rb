class Reservation < ApplicationRecord

	enum payment_status: [:unpaid, :paid]

	# Association
	belongs_to :user
	belongs_to :listing
end