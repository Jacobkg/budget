class Account < ActiveRecord::Base
  attr_accessible

  def self.add_account(name)
    account = Account.new
    account.name = name
    account.balance_in_cents = 0
    account.save!
  end

  def self.by_name(account_name)
    if account_name == "Out"
      OutsideAccount.new
    else
      Account.find_by_name!(account_name)
    end
  end

  def self.by_id(account_id)
    Account.find(account_id)
  end

  def self.transferable
    Account.all + [OutsideAccount.new]
  end

  def balance
    Money.new(balance_in_cents)
  end

  def set_balance(new_balance)
    self.balance_in_cents = new_balance.cents
    save!
  end

  def subtract(amount)
    set_balance(balance - amount)
  end

  def add(amount)
    set_balance(balance + amount)
  end

end

class OutsideAccount

  def name
    "Out"
  end

  def add(amount)
  end

  def subtract(amount)
  end

end
