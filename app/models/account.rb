class Account < ActiveRecord::Base
  attr_accessible

  def self.by_name(account_name)
    Account.find_by_name!(account_name)
  end

  def balance
    Money.new(balance_in_cents)
  end

  def deduct(amount)
    self.balance_in_cents -= amount.cents
    save!
  end

end
