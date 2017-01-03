class ReservationsController < ApplicationController
before_action :find_listing, only: [:new, :create]
before_action :find_reservation, only: [:show]

	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = Reservation.new(reservation_params)
		if @reservation.save
			ReservationMailer.reservation_email(@listing.user)
			redirect_to @reservation
		else
			render 'new'
		end
	end

	def show
		@client_token = Braintree::ClientToken.generate
	end

	def checkout

	end

private

def reservation_params
	params.require(:reservation).permit(:booking_start, :booking_end, :user_id, :listing_id)
end

def find_listing
	@listing = Listing.find_by_id(params[:listing_id])
end

def find_reservation
	@reservation = Reservation.find_by_id(params[:id])
end

end