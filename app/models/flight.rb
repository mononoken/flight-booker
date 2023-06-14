class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport", inverse_of: "departing_flights"
  belongs_to :arrival_airport, class_name: "Airport", inverse_of: "arriving_flights"

  scope :departure_codes,
    -> { joins(:departure_airport).distinct.order(:code).pluck(:code) }
  scope :arrival_codes,
    -> { joins(:arrival_airport).distinct.order(:code).pluck(:code) }
  scope :distinct_depart_dates,
    lambda {
      distinct.order(:start).pluck(:start).map do |start_datetime|
        start_datetime.strftime("%F")
      end
    }
end
