require "spec_helper"

feature "Spreadsheet Stats" do

  scenario "Show totals for each category" do
    BudgetItem.by_category("Food").set_amount(Money.new(15000))
    BudgetItem.by_category("Rent").set_amount(Money.new(120000))

    Expense.report(Date.today, "One", "Food", Money.new(1000), "Credit Card")
    Expense.report(Date.today, "Two", "Rent", Money.new(120000), "Checking" )
    Expense.report(Date.today, "Three", "Food", Money.new(1500), "Credit Card")

    visit "/"
    within('#monthly') do
      page.should have_content "Food $25.00 $150.00 $125.00"
      page.should have_content "Rent $1,200.00 $1,200.00 $0.00"
      page.should have_content "Phone $0.00 $0.00 $0.00"
    end

    within('#yearly') do
      page.should have_content "Medical $0.00"
      page.should_not have_content "Medical $0.00 $0.00"
    end
  end

end

