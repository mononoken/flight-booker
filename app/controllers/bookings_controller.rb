class BookingsController < ApplicationController
  def new
    @booking = Booking.new(flight_id: params[:flight_id])
    @num_tickets = params[:num_tickets]
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def bookings_params
    params.require(:bookings).permit(nil)
  end
end
