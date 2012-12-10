describe BudgetItem do

  it "can be created" do
    BudgetItem.add_to_budget("FooBar")
    BudgetItem.last.category.should == "FooBar"
    BudgetItem.last.amount.should == Money.new(0)
  end

  it "can edit the amount" do
    BudgetItem.add_to_budget("FooBar")
    BudgetItem.last.set_amount(Money.new(150))
    BudgetItem.last.amount.should == Money.new(150)
  end

end