class Account

  def self.balance(account_type)
    if account_type == "Credit Card"
      Money.new(0) - LineItem.credit_card.inject(Money.new(0)) {|sum, x| sum + x.amount}
    elsif account_type == "Checking"
      Money.new(100000) - LineItem.checking.inject(Money.new(0)) {|sum, x| sum + x.amount}
    else
      raise "Unknow Account Type"
    end
  end

end