class LineItem < ActiveRecord::Base
  attr_accessible

  def amount
    Money.new(amount_in_cents)
  end

  def self.add_to_spreadsheet(date, description, amount, category)
    line_item = LineItem.new
    line_item.description = description
    line_item.amount_in_cents = amount.cents
    line_item.date = date
    line_item.category = category
    line_item.save!
    line_item
  end

  def self.this_month
    LineItem.where(["date >= ?", Date.today.beginning_of_month]).order("date asc")
  end
end
