# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
airports = %w[ATL AUS DEN DFW JFK LAX LGA ORD SEA SFO]
airports.each do |code|
  Airport.create(code:)
end

10.times do
  departure_airport_code = airports.sample
  arrival_airport_code = (airports - [departure_airport_code]).sample

  Flight.create(
    departure_airport: Airport.find_by(code: departure_airport_code),
    arrival_airport: Airport.find_by(code: arrival_airport_code),
    start: rand(1.years).seconds.from_now,
    duration: rand(6).hours + rand(59).minutes
  )
end
