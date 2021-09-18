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

banks = ["HSBC", "Barclays", "Lloyds", "Natwest", "Santander", "Halifax", "Nationwide", "TSB", "Royal Bank of Scotland", "Ulster", "First Direct", "Monzo", "Starling", "US Bank"]

balances = [500, 1000, 2000, 5000, 7000, 12000]

puts "Creating our first user John..."
john = User.create!(email: "john@gmail.com", password: "tester", first_name: "John", last_name: "Smith")
puts "John has been created!"

puts "Now we will add a few bank accounts to John's FinMan..."
4.times do
  Account.create!(currency: "GBP", bank_name: banks.sample, account_number: 8.times.map{rand(1..9)}.join.to_i, sort_code: 6.times.map{rand(1..9)}.join.to_i, balance: balances.sample, user_id: john.id)
end
puts "That's been hopefully done too."

## Jake Demo Account
puts "Creating Jake Demo Account"
demo_user = User.create(email: "j@gmail.com", password: "tester", first_name: "Jake", last_name: "Monger")
a1 = Account.create(currency: "GBP", bank_name: "HSBC", account_number: 63369836, sort_code: 544789, balance: 2502, user_id: demo_user.id)
a2 = Account.create(currency: "GBP", bank_name: "Santander", account_number: 24465877, sort_code: 669845, balance: 3250, user_id: demo_user.id)
a3 = Account.create(currency: "USD", bank_name: "US Bank", account_number: 77454390, sort_code: 788456, balance: 545, user_id: demo_user.id)
a4 = Account.create(currency: "GBP", bank_name: "Barclays", account_number: 56733478, sort_code: 345967, balance: 10552, user_id: demo_user.id)

puts "Creating Demo Goals"
g1 = Goal.create(name: "BMW M3", target_amount: 23000, target_due_date: "2021-04-16 19:00:14", current_amount: 23000, start_date: "2020-09-16 19:00:14", user_id: demo_user.id, category: "Car", subject: "BMW M3")
g2 = Goal.create(name: "Deposit", target_amount: 12000, target_due_date: "2022-09-16 19:00:14", current_amount: 1000, start_date: "2020-08-16 19:00:14", user_id: demo_user.id, category: "Home", subject: "New Home Deposit")

puts "Creating Demo Goal Transactions"
gt1 = GoalsTransaction.create(goal_id: g1.id, amount: 10000, time: "2021-05-16 19:00:14", account_id: a4.id)
gt2 = GoalsTransaction.create(goal_id: g1.id, amount: 10000, time: "2021-06-16 19:00:14", account_id: a4.id)
gt3 = GoalsTransaction.create(goal_id: g1.id, amount: 3000, time: "2021-06-30 19:00:14", account_id: a4.id)

gt4 = GoalsTransaction.create(goal_id: g2.id, amount: 1000, time: "2021-06-30 19:00:14", account_id: a2.id)

puts "Creating Demo Account Transactions"
at1 = Transaction.create(account_id: a4.id, amount: 20000, recipient: "From Savings", time: "2021-05-16 17:00:14")
at3 = Transaction.create(account_id: a4.id, amount: 3000, recipient: "From Jamie", time: "2021-05-16 18:00:14")
at4 = Transaction.create(account_id: a4.id, amount: -10000, recipient: "Deposit Goal", time: "2021-05-16 19:00:14")
at5 = Transaction.create(account_id: a4.id, amount: -10000, recipient: "Deposit Goal", time: "2021-05-16 19:00:14")
at6 = Transaction.create(account_id: a4.id, amount: -3000, recipient: "Deposit Goal", time: "2021-05-16 19:00:14")

at7 = Transaction.create(account_id: a4.id, amount: -1000, recipient: "Deposit Goal", time: "2021-08-16 19:00:14")

