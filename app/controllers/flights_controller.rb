class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
    # @flight = Flight.find(params[:id])
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
      .permit(:departure_airport_id, :arrival_airport_id, :start, :duartion)
  end
end