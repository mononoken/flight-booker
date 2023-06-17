class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    @matching_flights = if params[:search].present?
      Flight.search(params[:search])
    else
      @matching_flights = Flight.all
    end

    if turbo_frame_request?
      render partial: "matching_flights", locals: {matching_flights: @matching_flights}
    else
      render :index
    end
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)

    if @flight.save
      redirect_to @flight
    else
      render "new"
    end
  end

  private

  def flight_params
    params.require(:flight)
      .permit(:departure_airport_id, :arrival_airport_id, :start, :duration)
  end
end
