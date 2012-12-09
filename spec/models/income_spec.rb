require 'spec_helper'

describe Income do

  it "can filter line items by month" do
    current = Income.report(Date.today, "One", Money.new(1))
    old = Income.report(Date.today - 1.month, "Two", Money.new(1))
    Income.this_month.should == [ current ]
  end

  it "orders line items chronologically from oldest to newest" do
    first = Income.report(Date.today.beginning_of_month, "One", Money.new(1))
    last = Income.report(Date.today.beginning_of_month + 2.days, "Two", Money.new(1))
    middle = Income.report(Date.today.beginning_of_month + 1.days, "Three", Money.new(1))
    Income.this_month.should == [first, middle, last]
  end

  describe ".add_to_spreadsheet" do

    it "persists the data" do
      Income.report(Date.today, "Holiday Bonus", Money.new(525))
      Income.last.description.should == "Holiday Bonus"
      Income.last.amount.should == Money.new(525)
      Income.last.date.should == Date.today
    end

    it "Adds the amount to the account" do
      expect {
        Income.report(Date.today, "Holiday Bonus", Money.new(525))
      }.to change { Account.by_name("Checking").balance }.by(Money.new(525))
    end

  end

end