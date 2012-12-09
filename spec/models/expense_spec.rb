require 'spec_helper'

describe Expense do

  it "can filter line items by month" do
    current = Expense.report(Date.today, "One", "Food", Money.new(1), "Credit Card")
    old = Expense.report(Date.today - 1.month, "Two", "Food", Money.new(1), "Credit Card")
    Expense.this_month.should == [ current ]
  end

  it "orders line items chronologically from oldest to newest" do
    first = Expense.report(Date.today.beginning_of_month, "One", "Food", Money.new(1), "Credit Card")
    last = Expense.report(Date.today.beginning_of_month + 2.days, "Two", "Food", Money.new(1), "Credit Card")
    middle = Expense.report(Date.today.beginning_of_month + 1.days, "Three", "Food", Money.new(1), "Credit Card")
    Expense.this_month.should == [first, middle, last]
  end

  it "can retrieve by id" do
    expense = Expense.report(Date.today - 1.days, "A long walk", "Food", Money.new(525), "Credit Card")
    Expense.by_id(expense.id).should == expense
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
