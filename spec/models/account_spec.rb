require 'spec_helper'

describe Account do

  it "has $0 balance when no line items for Credit Card" do
    Account.by_name("Credit Card").balance.should == Money.new(0)
  end

  it "has $1000 balance when no line items for Checking" do
    Account.by_name("Checking").balance.should == Money.new(100000)
  end

  it "can deduct from accounts" do
    Account.by_name("Checking").deduct(Money.new(10000))
    Account.by_name("Checking").balance.should == Money.new(90000)
  end

end