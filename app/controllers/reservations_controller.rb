class ReservationsController < ApplicationController
before_action :find_listing, only: [:new]
before_action :find_reservation, only: [:show, :checkout]

	def new
		@reservation = Reservation.new
	end

	def create
		@listing = Listing.find(params[:reservation][:listing_id])
		@reservation = Reservation.new(reservation_params)
		if @reservation.save
			ReservationEmailJob.perform_later(@listing, @listing.id, @reservation.id)
			redirect_to @reservation
		else
			flash[:notice] = "Reservation Failed"
			redirect_to new_reservation_path(listing_id: params[:reservation][:listing_id])
		end
	end

	def show
		@client_token = Braintree::ClientToken.generate
	end

	def checkout
		nonce_form_the_client = params[:checkout_form][:payment_method_nonce]

		result = Braintree::Transaction.sale(
			amount: "#{@reservation.listing.price / 10000 }",
			payment_method_nonce: nonce_form_the_client,
			options: {
				submit_for_settlement: true
			}
			)
		if result.success?
			@reservation.update(payment_status: 1)
			redirect_to :root, flash: { success: "Transaction successful!" }
		else
			redirect_to :root, flash: { error: "Transaction failed. Please try again." }
		end

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