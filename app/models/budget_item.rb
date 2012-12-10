class BudgetItem < ActiveRecord::Base
  attr_accessible

  def self.add_to_budget(category)
    budget_item = BudgetItem.new
    budget_item.category = category
    budget_item.save!
  end

  def amount
    Money.new(amount_in_cents)
  end

  def set_amount(new_amount)
    self.amount_in_cents = new_amount.cents
    self.save!
  end

end
