require 'spec_helper'

describe Expense do

  it "can filter line items by month" do
    Expense.report(Date.today, "Current", "Food", Money.new(1), "Credit Card")
    Expense.report(Date.today - 1.month, "Old", "Food", Money.new(1), "Credit Card")
    Expense.this_month.map(&:description).should == [ "Current" ]
  end

  it "orders line items chronologically from oldest to newest" do
    Expense.report(Date.today.beginning_of_month, "First", "Food", Money.new(1), "Credit Card")
    Expense.report(Date.today.beginning_of_month + 2.days, "Last", "Food", Money.new(1), "Credit Card")
    Expense.report(Date.today.beginning_of_month + 1.days, "Middle", "Food", Money.new(1), "Credit Card")
    Expense.this_month.map(&:description).should == ["First", "Middle", "Last"]
  end

  it "can retrieve by id" do
    Expense.report(Date.today - 1.days, "A long walk", "Food", Money.new(525), "Credit Card")
    Expense.by_id(Expense.last.id).should == Expense.last
  end

  describe ".add_to_spreadsheet" do

    it "persists the data" do
      Expense.report(Date.today - 1.days, "A long walk", "Food", Money.new(525), "Credit Card")
      Expense.last.description.should == "A long walk"
      Expense.last.amount.should == Money.new(525)
      Expense.last.date.should == Date.today - 1.days
      Expense.last.category.should == "Food"
      Expense.last.account.should == "Credit Card"
    end

    it "deducts the amount from the account" do
      expect {
        Expense.report(Date.today, "A long walk", "Food", Money.new(525), "Credit Card")
      }.to change { Account.by_name("Credit Card").balance }.by(Money.new(-525))
    end

  end

end
