class Expense < ActiveRecord::Base
  attr_accessible

  default_scope order("date ASC")

  scope :this_month, where(["date >= ?", Date.today.beginning_of_month])

  def amount
    Money.new(amount_in_cents)
  end

  def self.add_to_spreadsheet(date, description, category, amount, account)
    expense = Expense.new
    expense.description = description
    expense.amount_in_cents = amount.cents
    expense.date = date
    expense.category = category
    expense.account = account
    expense.save!
    expense
  end

  def self.sum_up(expense_association)
    expense_association.inject(Money.new(0)) {|sum, x| sum + x.amount}
  end

end
