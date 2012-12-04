require "spec_helper"

feature "Spreadsheet Stats" do

  scenario "Show totals for each category" do
    Expense.add_to_spreadsheet(Date.today, "One", "Food", Money.new(125), "Credit Card")
    Expense.add_to_spreadsheet(Date.today, "Two", "Rent", Money.new(120000), "Checking" )
    Expense.add_to_spreadsheet(Date.today, "Three", "Food", Money.new(150), "Credit Card")

    visit "/"
    within("#category-stats") do
      page.should have_content "Food $2.75"
      page.should have_content "Rent $1,200.00"
      page.should have_content "Phone $0.00"
    end
  end

end

