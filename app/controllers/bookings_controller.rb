class BookingsController < ApplicationController
  def new
    @booking = Booking.new(flight_id: params[:flight_id])

    @flight = Flight.find(params[:flight_id])

    @num_tickets = params[:num_tickets].to_i
    @num_tickets.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    @num_tickets = params[:num_tickets].to_i
    @num_tickets.times do
      @booking.passengers.build(booking_params[:passengers])
    end

    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
  end
end
