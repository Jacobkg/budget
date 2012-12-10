require "spec_helper"

feature "Spreadsheet Stats" do

  scenario "Show totals for each category" do
    Expense.report(Date.today, "One", "Food", Money.new(125), "Credit Card")
    Expense.report(Date.today, "Two", "Rent", Money.new(120000), "Checking" )
    Expense.report(Date.today, "Three", "Food", Money.new(150), "Credit Card")

    visit "/"
    within("#category-stats") do
      page.should have_content "Food $2.75"
      page.should have_content "Rent $1,200.00"
      page.should have_content "Phone $0.00"
    end
  end

  scenario "Shows the budget for each category" do
    BudgetItem.by_category("Food").set_amount(Money.new(15000))

    visit "/"
    within("#category-stats") do
      page.should have_content "Food $0.00 $150.00"
    end
  end

  scenario "Shows the amount remaining for each category" do
    BudgetItem.by_category("Food").set_amount(Money.new(15000))
    Expense.report(Date.today, "One", "Food", Money.new(2500), "Credit Card")

    visit "/"
    within("#category-stats") do
      page.should have_content "Food $25.00 $150.00 $125.00"
    end
  end

end

