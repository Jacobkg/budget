# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

credit_card = Account.new
credit_card.name = "Credit Card"
credit_card.save!

checking = Account.new
checking.name = "Checking"
checking.balance_in_cents = 100000
checking.save!
