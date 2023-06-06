class Flight < ApplicationRecord
  belongs_to :departure_airport, class: "Airport", inverse_of: "departing_flights"
  belongs_to :arrival_airport, class: "Airport", inverse_of: "arriving_flights"
end
