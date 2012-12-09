require 'spec_helper'

describe Account do

  it "has $0 balance when no line items for Credit Card" do
    Account.by_name("Credit Card").balance.should == Money.new(0)
  end

  it "has $1000 balance when no line items for Checking" do
    Account.by_name("Checking").balance.should == Money.new(100000)
  end

  it "can subtract from accounts" do
    Account.by_name("Checking").subtract(Money.new(10000))
    Account.by_name("Checking").balance.should == Money.new(90000)
  end

  it "can add to accounts" do
    Account.by_name("Checking").add(Money.new(10000))
    Account.by_name("Checking").balance.should == Money.new(110000)
  end

  it "can set the balance" do
    Account.by_name("Credit Card").set_balance(Money.new(-150))
    Account.by_name("Credit Card").balance.should == Money.new(-150)
  end

  it "can retrieve by id" do
    account = Account.by_name("Credit Card")
    Account.by_id(account.id).should == account
  end

  describe ".transferable" do

    it "Includes the account 'Out'" do
      Account.transferable.map(&:name).should include("Out")
    end

  end

  describe "Outside accounts" do

    it "is returned when you search by name 'Out'" do
      Account.by_name("Out").name.should == "Out"
    end

    it "does nothing when you call add" do
      Account.by_name("Out").add(Money.new(100))
    end

  end

end