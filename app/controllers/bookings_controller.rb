class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])

    @booking = Booking.new(flight_id: params[:flight_id])

    @num_tickets = params[:num_tickets].to_i
    @num_tickets.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      @booking.passengers.each do |passenger|
        PassengerMailer
          .with(booking: @booking, passenger:)
          .confirmation_email.deliver_later
      end

      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = Flight.find(@booking.flight_id)
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
  end
end
