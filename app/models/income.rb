class Income < ActiveRecord::Base
  attr_accessible

  default_scope order("date ASC")

  scope :this_month, where(["date >= ?", Date.today.beginning_of_month])

  def amount
    Money.new(amount_in_cents)
  end

  def self.add_to_spreadsheet(date, description, amount)
    income = Income.new
    income.date = date
    income.description = description
    income.amount_in_cents = amount.cents
    income.save!
    income
  end

end
