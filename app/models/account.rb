class Account

  def self.balance(account_type)
    if account_type == "Credit Card"
      Money.new(0) - LineItem.add_up(LineItem.credit_card)
    elsif account_type == "Checking"
      Money.new(100000) - LineItem.add_up(LineItem.checking)
    else
      raise "Unknown Account Type"
    end
  end

end