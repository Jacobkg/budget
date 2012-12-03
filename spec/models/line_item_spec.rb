require 'spec_helper'

describe LineItem do

  it "persists the data" do
    LineItem.add_to_spreadsheet("A long walk", Money.new(525), Date.today - 1.days)
    LineItem.last.description.should == "A long walk"
    LineItem.last.amount.should == Money.new(525)
    LineItem.last.date.should == Date.today - 1.days
  end

  it "can filter line items by month" do
    current = LineItem.add_to_spreadsheet("One", Money.new(1), Date.today)
    old = LineItem.add_to_spreadsheet("Two", Money.new(1), Date.today - 1.month)
    LineItem.this_month.should == [ current ]
  end

  it "orders line items chronologically from oldest to newest" do
    first = LineItem.add_to_spreadsheet("One", Money.new(1), Date.today.beginning_of_month)
    last = LineItem.add_to_spreadsheet("Two", Money.new(1), Date.today.beginning_of_month + 2.days)
    middle = LineItem.add_to_spreadsheet("Three", Money.new(1), Date.today.beginning_of_month + 1.days)
    LineItem.this_month.should == [first, middle, last]
  end

end
