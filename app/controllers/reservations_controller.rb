class ReservationsController < ApplicationController
before_action :find_listing, only: [:new, :create]

	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = Reservation.new(reservation_params)
		if @reservation.save
			redirect_to user_listing_path(@listing.user_id, @listing.id)
		else
			render 'new'
		end
	end

private

def reservation_params
	params.require(:reservation).permit(:booking_start, :booking_end, :user_id, :listing_id)
end

def find_listing
	@listing = Listing.find_by_id(params[:listing_id])
end

end