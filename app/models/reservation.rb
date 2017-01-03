class Reservation < ApplicationRecord

	enum payment_status: [:unpaid, :paid]

	# Association
	belongs_to :user
	belongs_to :listing

	#  Validations
	validates :booking_start, presence: true
	validates :booking_end, presence: true
end