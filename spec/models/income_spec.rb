require 'spec_helper'

describe Income do

  it "can filter line items by month" do
    Income.report(Date.today, "Current", Money.new(1))
    Income.report(Date.today - 1.month, "Last", Money.new(1))
    Income.this_month.map(&:description).should == [ "Current" ]
  end

  it "orders line items chronologically from oldest to newest" do
    Income.report(Date.today.beginning_of_month, "First", Money.new(1))
    Income.report(Date.today.beginning_of_month + 2.days, "Last", Money.new(1))
    Income.report(Date.today.beginning_of_month + 1.days, "Middle", Money.new(1))
    Income.this_month.map(&:description).should == ["First", "Middle", "Last"]
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