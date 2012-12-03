require 'spec_helper'

describe LineItem do

  it "persists the data" do
    LineItem.add_to_spreadsheet(Date.today - 1.days, "A long walk", "Food", Money.new(525), "Credit Card")
    LineItem.last.description.should == "A long walk"
    LineItem.last.amount.should == Money.new(525)
    LineItem.last.date.should == Date.today - 1.days
    LineItem.last.category.should == "Food"
    LineItem.last.account.should == "Credit Card"
  end

  it "can filter line items by month" do
    current = LineItem.add_to_spreadsheet(Date.today, "One", "Food", Money.new(1), "Credit Card")
    old = LineItem.add_to_spreadsheet(Date.today - 1.month, "Two", "Food", Money.new(1), "Credit Card")
    LineItem.this_month.should == [ current ]
  end

  it "can filter line items by account type" do
    credit_card = LineItem.add_to_spreadsheet(Date.today, "One", "Food", Money.new(1), "Credit Card")
    checking = LineItem.add_to_spreadsheet(Date.today - 1.month, "Two", "Food", Money.new(1), "Checking")
    LineItem.credit_card.should == [ credit_card ]
    LineItem.checking.should == [ checking ]
  end

  it "orders line items chronologically from oldest to newest" do
    first = LineItem.add_to_spreadsheet(Date.today.beginning_of_month, "One", "Food", Money.new(1), "Credit Card")
    last = LineItem.add_to_spreadsheet(Date.today.beginning_of_month + 2.days, "Two", "Food", Money.new(1), "Credit Card")
    middle = LineItem.add_to_spreadsheet(Date.today.beginning_of_month + 1.days, "Three", "Food", Money.new(1), "Credit Card")
    LineItem.this_month.should == [first, middle, last]
  end

end
