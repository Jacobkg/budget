require "spec_helper"

feature "Spreadsheet Display" do

  scenario "Shows the line items for the current month in order" do
    #Given some line items from this month and last month
    LineItem.add_to_spreadsheet(Date.today.beginning_of_month + 15.days, "Bagels", "Food", Money.new(125), "Credit Card")
    LineItem.add_to_spreadsheet(Date.today.beginning_of_month, "ITunes", "Entertainment", Money.new(99), "Checking" )
    LineItem.add_to_spreadsheet(Date.today.beginning_of_month - 1.day, "Last month's rent", "Rent", Money.new(100000), "Credit Card")

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

    #And they should be in chronological order
    page.body.should match /.*ITunes.*Bagels.*/m
  end
end