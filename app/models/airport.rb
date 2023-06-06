class Airport < ApplicationRecord
  has_many :arriving_flights, class: "Flight", inverse_of: "arrival_airport"
  has_many :departing_flights, class: "Flight", inverse_of: "departure_airport"

  validates :code, presence: true, uniqueness: true
end
