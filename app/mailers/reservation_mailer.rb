class ReservationMailer < ApplicationMailer
	default from: "micerailsrat@gmail.com"

	def reservation_email(user)
		@user = user
		mail(to: @user.email, subject: 'New Reservation')
	end

end
