class BudgetItem < ActiveRecord::Base
  attr_accessible

  scope :monthly, where(:period => "Monthly")
  scope :yearly, where(:period => "Yearly")

  def self.by_category(category)
    find_by_category!(category)
  end

  def self.add_to_budget(category, period)
    budget_item = BudgetItem.new
    budget_item.category = category
    budget_item.period = period
    budget_item.save!
  end

  def amount
    Money.new(amount_in_cents)
  end

  def set_amount(new_amount)
    self.amount_in_cents = new_amount.cents
    self.save!
  end

  def used_this_month
    Expense.sum_up(Expense.this_month.where(:category => category))
  end

end
