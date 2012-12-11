# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Account.add_account("Credit Card")
Account.add_account("Checking")
Account.by_name("Checking").set_balance(Money.new(100000))

[ "Food", "Rent", "Phone", "Gas", "Utilities", "Necessities", "Entertainment" ].each do |category|
  BudgetItem.add_to_budget(category, "Monthly")
end

[ "Big Purchases", "Medical", "Gifts", "Clothes" ].each do |category|
  BudgetItem.add_to_budget(category, "Yearly")
end
