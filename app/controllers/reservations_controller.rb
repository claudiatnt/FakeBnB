class ReservationsController < ApplicationController
before_action :find_listing, only: [:new, :create]
before_action :find_reservation, only: [:show, :checkout]

	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = Reservation.new(reservation_params)
		if @reservation.save
			redirect_to @reservation
		else
			render 'new'
		end
	end

	def show
		@client_token = Braintree::ClientToken.generate
	end

	def checkout
		nonce_form_the_client = params[:checkout_form][:payment_method_nonce]

		result = Braintree::Transaction.sale(
			amount: "#{@reservation.listing.price}",
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