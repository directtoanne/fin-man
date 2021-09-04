# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GoalsTransaction.destroy_all
Transaction.destroy_all
Account.destroy_all
Goal.destroy_all
User.destroy_all

banks = ["HSBC", "Barclays", "Lloyds", "Natwest", "Santander", "Halifax", "Nationwide", "TSB", "Royal Bank of Scotland", "Ulster", "First Direct", "Monzo", "Starling", "Other"]

balances = [500, 1000, 2000, 5000, 10000, 20000]

puts "Creating our first user John..."
john = User.create!(email: "john@gmail.com", password: "tester", first_name: "John", last_name: "Smith")
puts "John has been created!"

puts "Now we will add a few bank accounts to John's FinMan..."
5.times do
  Account.create!(currency: "£", bank_name: banks.sample, account_number: 8.times.map{rand(1..9)}.join.to_i, sort_code: 6.times.map{rand(1..9)}.join.to_i, balance: balances.sample, user_id: john.id)
end
puts "That's been hopefully done too."
