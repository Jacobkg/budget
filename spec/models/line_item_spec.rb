require 'spec_helper'

describe LineItem do

  it "persists the data" do
    LineItem.add_to_spreadsheet(Date.today - 1.days, "A long walk", Money.new(525), "Food")
    LineItem.last.description.should == "A long walk"
    LineItem.last.amount.should == Money.new(525)
    LineItem.last.date.should == Date.today - 1.days
    LineItem.last.category.should == "Food"
  end

  it "can filter line items by month" do
    current = LineItem.add_to_spreadsheet(Date.today, "One", Money.new(1), "Food")
    old = LineItem.add_to_spreadsheet(Date.today - 1.month, "Two", Money.new(1), "Food")
    LineItem.this_month.should == [ current ]
  end

  it "orders line items chronologically from oldest to newest" do
    first = LineItem.add_to_spreadsheet(Date.today.beginning_of_month, "One", Money.new(1), "Food")
    last = LineItem.add_to_spreadsheet(Date.today.beginning_of_month + 2.days, "Two", Money.new(1), "Food")
    middle = LineItem.add_to_spreadsheet(Date.today.beginning_of_month + 1.days, "Three", Money.new(1), "Food")
    LineItem.this_month.should == [first, middle, last]
  end

end
