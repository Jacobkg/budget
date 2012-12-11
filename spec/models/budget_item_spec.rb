describe BudgetItem do

  it "can be created" do
    BudgetItem.add_to_budget("FooBar", "Monthly")
    BudgetItem.last.category.should == "FooBar"
    BudgetItem.last.amount.should == Money.new(0)
    BudgetItem.last.period.should == "Monthly"
  end

  it "can edit the amount" do
    BudgetItem.add_to_budget("FooBar", "Monthly")
    BudgetItem.last.set_amount(Money.new(150))
    BudgetItem.last.amount.should == Money.new(150)
  end

  it "can retrieve by period" do
    BudgetItem.destroy_all
    BudgetItem.add_to_budget("FooBar", "Monthly")
    BudgetItem.add_to_budget("FizzBuzz", "Yearly")
    BudgetItem.monthly.map(&:category).should == [ "FooBar" ]
    BudgetItem.yearly.map(&:category).should == [ "FizzBuzz" ]
  end

end