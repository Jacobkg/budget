class LineItem < ActiveRecord::Base
  attr_accessible

  CATEGORIES = ["Food", "Rent", "Phone", "Medical", "Entertainment"]

  def amount
    Money.new(amount_in_cents)
  end

  def self.this_month
    LineItem.where(["date >= ?", Date.today.beginning_of_month]).order("date asc")
  end

  def self.credit_card
    LineItem.where(:account => "Credit Card")
  end

  def self.checking
    LineItem.where(:account => "Checking")
  end

  def self.add_to_spreadsheet(date, description, category, amount, account)
    line_item = LineItem.new
    line_item.description = description
    line_item.amount_in_cents = amount.cents
    line_item.date = date
    line_item.category = category
    line_item.account = account
    line_item.save!
    line_item
  end
end
