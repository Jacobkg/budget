class LineItem < ActiveRecord::Base
  attr_accessible

  default_scope order("date ASC")

  scope :this_month, where(["date >= ?", Date.today.beginning_of_month])

  def amount
    Money.new(amount_in_cents)
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

  def self.sum_up(line_item_association)
    line_item_association.inject(Money.new(0)) {|sum, x| sum + x.amount}
  end

end
