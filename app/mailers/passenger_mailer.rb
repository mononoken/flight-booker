class PassengerMailer < ApplicationMailer
  default from: "notifications@example.com"

  def confirmation_email
    @booking = params[:booking]
    @flight = @booking.flight
    @passenger = params[:passenger]
    @url = "http://localhost:3000/bookings/#{@booking.id}"
    mail(to: @passenger.email, subject: "Your Booking Confirmation")
  end
end
