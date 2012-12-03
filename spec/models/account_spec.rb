require 'spec_helper'

describe Account do

  it "has $0 balance when no line items for Credit Card" do
    Account.balance("Credit Card").should == Money.new(0)
  end

  it "has $1000 balance when no line items for Checking" do
    Account.balance("Checking").should == Money.new(100000)
  end

  it "calculates balance by type" do
    LineItem.add_to_spreadsheet(Date.today, "One", "Food", Money.new(125), "Credit Card")
    LineItem.add_to_spreadsheet(Date.today, "Two", "Food", Money.new(50000), "Checking")

    Account.balance("Credit Card").should == Money.new(-125)
    Account.balance("Checking").should == Money.new(50000)
  end

end