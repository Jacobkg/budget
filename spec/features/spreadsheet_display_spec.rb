require "spec_helper"

feature "Spreadsheet Display" do

  scenario "Shows the line items for the current month in order" do
    #Given some line items from this month and last month
    LineItem.add_to_spreadsheet("Bagels", Money.new(125), Date.today.beginning_of_month + 15.days)
    LineItem.add_to_spreadsheet("Coffee", Money.new(99), Date.today.beginning_of_month)
    LineItem.add_to_spreadsheet("Last month's rent", Money.new(100000), Date.today.beginning_of_month - 1.day)

    #When I visit the home page
    visit "/"

    #Then I should see the expenses from this month
    page.should have_content Date.today.strftime("%B")

    page.should have_content "Bagels"
    page.should have_content "$1.25"

    page.should have_content "Coffee"
    page.should have_content "$0.99"

    page.should_not have_content "Last month's rent"

    #And they should be in chronological order
    page.body.should match /.*Coffee.*Bagels.*/m
  end
end