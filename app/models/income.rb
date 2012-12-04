class Income < ActiveRecord::Base
  attr_accessible

  def amount
    Money.new(amount_in_cents)
  end

  def self.add_to_spreadsheet(description, amount)
    income = Income.new
    income.description = description
    income.amount_in_cents = amount.cents
    income.save!
    income
  end

end
