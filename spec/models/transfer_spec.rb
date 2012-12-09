require 'spec_helper'

describe Transfer do

  describe ".execute" do
    it "persists the transfer" do
      Transfer.execute("Description", Money.new(100), "Credit Card", "Checking")
      Transfer.last.description.should == "Description"
      Transfer.last.amount.should == Money.new(100)
      Transfer.last.source_account.should == "Credit Card"
      Transfer.last.destination_account.should == "Checking"
    end

    it "withdraws the amount from the source account" do
      expect {
        Transfer.execute("Description", Money.new(100), "Checking", "Credit Card")
      }.to change { Account.by_name("Checking").balance}.by(Money.new(-100))
    end

    it "adds the amount to the destination account" do
      expect {
        Transfer.execute("Description", Money.new(100), "Checking", "Credit Card")
      }.to change { Account.by_name("Credit Card").balance}.by(Money.new(100))
    end
  end

end
