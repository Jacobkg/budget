class Expense < ActiveRecord::Base
  attr_accessible

  default_scope order("date ASC")

  scope :this_month, where(["date >= ?", Date.today.beginning_of_month])

  def amount
    Money.new(amount_in_cents)
  end

  def self.by_id(expense_id)
    Expense.find(expense_id)
  end

  def self.report(date, description, category, amount, account)
    create_expense(date, description, category, amount, account)
    Account.by_name(account).subtract(amount)
  end

  def self.sum_up(expense_association)
    expense_association.inject(Money.new(0)) {|sum, x| sum + x.amount}
  end

  def self.default_date
    return Date.today if Expense.count == 0
    Expense.order("created_at desc").first.date
  end

  private

    def self.create_expense(date, description, category, amount, account)
      expense = Expense.new
      expense.description = description
      expense.amount_in_cents = amount.cents
      expense.date = date
      expense.category = category
      expense.account = account
      expense.save!
    end

end
