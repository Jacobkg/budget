require "spec_helper"

feature "Spreadsheet Display" do

  scenario "Shows the expenses for the current month in order" do
    #Given some expenses from this month and last month
    Expense.report(Date.today.beginning_of_month + 15.days, "Bagels", "Food", Money.new(125), "Credit Card")
    Expense.report(Date.today.beginning_of_month, "ITunes", "Entertainment", Money.new(99), "Checking" )
    Expense.report(Date.today.beginning_of_month - 1.day, "Last month's rent", "Rent", Money.new(100000), "Credit Card")

    #When I visit the home page
    visit "/"

    #Then I should see the expenses from this month
    page.should have_content Date.today.strftime("%B")

    page.should have_content "Bagels"
    page.should have_content "$1.25"
    page.should have_content "Food"
    page.should have_content "Credit Card"

    page.should have_content "ITunes"
    page.should have_content "$0.99"
    page.should have_content "Entertainment"
    page.should have_content "Checking"

    page.should_not have_content "Last month's rent"

    #And they should be in descending chronological order
    page.body.should match /.*Bagels.*ITunes.*/m
  end

  scenario "Shows the income for the current month in order" do
    #Given some income from this month and last month
    Income.report(Date.today.beginning_of_month + 28.days, "Bonus", Money.new(50000))
    Income.report(Date.today.beginning_of_month - 1.day, "Last Month Salary", Money.new(200000))
    Income.report(Date.today.beginning_of_month + 15.days, "This Month Salary", Money.new(200000))

    #When I visit the home page
    visit "/"

    #Then I should see the income for this month
    page.should have_content "This Month Salary"
    page.should have_content "$2,000.00"

    page.should have_content "Bonus"
    page.should have_content "$500.00"

    page.should_not have_content "Last Month Salary"

    #And it should be in chronological order
    page.body.should match /.*This Month Salary.*Bonus.*/m
  end

end