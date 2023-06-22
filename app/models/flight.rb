class Flight < ApplicationRecord
  scope :filter_by_date, ->(date) {
    where("start BETWEEN ? AND ?", date.to_date.beginning_of_day, date.to_date.end_of_day)
  }
  scope :filter_by_departure_code, ->(departure_code) {
    joins(:departure_airport).where(departure_airport: {code: departure_code})
  }
  scope :filter_by_arrival_code, ->(arrival_code) {
    joins(:arrival_airport).where(arrival_airport: {code: arrival_code})
  }

  scope :departure_codes,
    -> { joins(:departure_airport).distinct.order(:code).pluck(:code) }
  scope :arrival_codes,
    -> { joins(:arrival_airport).distinct.order(:code).pluck(:code) }
  scope :distinct_depart_dates,
    -> {
      distinct.order(:start).pluck(:start).map do |start_datetime|
        start_datetime.strftime("%F")
      end.uniq
    }

  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings
  belongs_to :departure_airport, class_name: "Airport", inverse_of: "departing_flights"
  belongs_to :arrival_airport, class_name: "Airport", inverse_of: "arriving_flights"
end
