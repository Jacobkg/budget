class Account < ActiveRecord::Base
  attr_accessible

  def self.by_name(account_name)
    Account.find_by_name!(account_name)
  end

  def balance
    Money.new(balance_in_cents)
  end

  def set_balance(new_balance)
    self.balance_in_cents = new_balance.cents
    save!
  end

  def deduct(amount)
    set_balance(balance - amount)
  end

end
