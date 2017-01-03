# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
	def reservation_mail_sample
		ReservationMailer.reservation_email(User.last)
	end
end
