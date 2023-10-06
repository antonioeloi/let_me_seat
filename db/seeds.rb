# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

n_rows = ENV.fetch("N_ROWS", 25).to_i
n_columns = ENV.fetch("N_COLUMNS", 20).to_i
n_rows.times do |row|
  n_columns.times do |column|
    Seat.create!(row: row, column: column, cost: rand(100..500))
  end
end