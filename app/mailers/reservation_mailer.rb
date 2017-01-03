class ReservationMailer < ApplicationMailer
	default from: "micerailsrat@gmail.com"

	def reservation_email(user, listing, reservation)
		@user = user
		@listing = Listing.find(listing)
		@reservation = Reservation.find(reservation)
		mail(to: @user.email, subject: 'New Reservation')
	end

end
