class LineItem < ActiveRecord::Base
  attr_accessible :amount_in_cents, :description, :date

  def amount
    Money.new(amount_in_cents)
  end

  def self.add_to_spreadsheet(description, amount, date)
    LineItem.create! :description => description, :amount_in_cents => amount.cents, :date => date
  end

  def self.this_month
    LineItem.where(["date >= ?", Date.today.beginning_of_month]).order("date asc")
  end
end
