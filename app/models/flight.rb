class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport', inverse_of: 'departing_flights'
  belongs_to :arrival_airport, class_name: 'Airport', inverse_of: 'arriving_flights'

  scope :distinct_departure_airports, -> { joins(:departure_airport).distinct.order(:code).pluck(:code) }
  scope :distinct_arrival_airports, -> { joins(:arrival_airport).distinct.order(:code).pluck(:code) }
end
