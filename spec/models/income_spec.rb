require 'spec_helper'

describe Income do

  it "persists the data" do
    Income.add_to_spreadsheet("Holiday Bonus", Money.new(525))
    Income.last.description.should == "Holiday Bonus"
    Income.last.amount.should == Money.new(525)
  end

end