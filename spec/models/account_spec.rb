require 'spec_helper'

describe Account do

  it "has $0 balance when no line items for Credit Card" do
    Account.by_name("Credit Card").balance.should == Money.new(0)
  end

  it "has $1000 balance when no line items for Checking" do
    Account.by_name("Checking").balance.should == Money.new(100000)
  end

  it "can subtract from accounts" do
    Account.by_name("Checking").subtract(Money.new(10000))
    Account.by_name("Checking").balance.should == Money.new(90000)
  end

  it "can add to accounts" do
    Account.by_name("Checking").add(Money.new(10000))
    Account.by_name("Checking").balance.should == Money.new(110000)
  end

  it "can set the balance" do
    Account.by_name("Credit Card").set_balance(Money.new(-150))
    Account.by_name("Credit Card").balance.should == Money.new(-150)
  end

  it "can retrieve by id" do
    account = Account.by_name("Credit Card")
    Account.by_id(account.id).should == account
  end

end