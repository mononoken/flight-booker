class Flight < ApplicationRecord
  def self.search(params)
    where(
      "start BETWEEN ? AND ?", params[:date].to_date.beginning_of_day, params[:date].to_date.end_of_day
    )
      .where(
        departure_airport_id: Airport.find_by(code: params[:departure_code])&.id,
        arrival_airport_id: Airport.find_by(code: params[:arrival_code])&.id
      )
  end

  scope :departure_codes,
    -> { joins(:departure_airport).distinct.order(:code).pluck(:code) }
  scope :arrival_codes,
    -> { joins(:arrival_airport).distinct.order(:code).pluck(:code) }
  scope :distinct_depart_dates,
    -> {
      distinct.order(:start).pluck(:start).map do |start_datetime|
        start_datetime.strftime("%F")
      end
    }

  belongs_to :departure_airport, class_name: "Airport", inverse_of: "departing_flights"
  belongs_to :arrival_airport, class_name: "Airport", inverse_of: "arriving_flights"
end
