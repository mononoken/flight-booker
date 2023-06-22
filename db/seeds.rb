# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Booking.delete_all
Flight.delete_all
Airport.delete_all

airports = %w[ATL DFW JFK LAX LGA SEA SFO]
airports.each do |code|
  Airport.create(code:)
end

# Generate 100 random flights for the next 30 days from today.
(DateTime.now..DateTime.now + 30.days).to_a.each do |day|
  100.times do
    departure_airport_code = airports.sample
    arrival_airport_code = (airports - [departure_airport_code]).sample

    Flight.create(
      departure_airport: Airport.find_by(code: departure_airport_code),
      arrival_airport: Airport.find_by(code: arrival_airport_code),
      start: day + rand(1.days).seconds,
      duration: rand(6).hours + rand(59).minutes # This duration is illogically randomized instead of calculated by distance.
    )
  end
end
