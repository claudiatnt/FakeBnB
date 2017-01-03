class ReservationEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ReservationMailer.reservation_email(args[0].user, args[1], args[2]).deliver_now
  end
end
