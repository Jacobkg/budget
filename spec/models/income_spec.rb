require 'spec_helper'

describe Income do

  it "persists the data" do
    Income.add_to_spreadsheet(Date.today, "Holiday Bonus", Money.new(525))
    Income.last.description.should == "Holiday Bonus"
    Income.last.amount.should == Money.new(525)
    Income.last.date.should == Date.today
  end

  it "can filter line items by month" do
    current = Income.add_to_spreadsheet(Date.today, "One", Money.new(1))
    old = Income.add_to_spreadsheet(Date.today - 1.month, "Two", Money.new(1))
    Income.this_month.should == [ current ]
  end

  it "orders line items chronologically from oldest to newest" do
    first = Income.add_to_spreadsheet(Date.today.beginning_of_month, "One", Money.new(1))
    last = Income.add_to_spreadsheet(Date.today.beginning_of_month + 2.days, "Two", Money.new(1))
    middle = Income.add_to_spreadsheet(Date.today.beginning_of_month + 1.days, "Three", Money.new(1))
    Income.this_month.should == [first, middle, last]
  end

end