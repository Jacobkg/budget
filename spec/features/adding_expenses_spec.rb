require "spec_helper"

feature "Adding Expenses" do

  background do
    visit "/"
  end

  scenario "Adding an expense to credit card updates the balance" do
    #Given a credit card balance of ($0)
    page.find("#credit-card-balance").should have_content "$0.00"

    #When I add an expense against my credit card of $25
    click_link "Add Expenses"
    fill_in "Description", :with => "Shopping at the mall"
    fill_in "Amount", :with => "$25.00"
    click_button "Save"

    #Then the expense should appear and my credit card balance should be ($25)
    page.should have_content "Shopping at the mall"
    page.find("#expenses").should have_content "Credit Card"
    page.find("#credit-card-balance").should have_content "$-25.00"
  end

  scenario "Add an expense to checking account" do
    #Given a checking account balance of $1000
    page.find("#checking-balance").should have_content "$1,000.00"

    #When I add an expense against my checking account of $150
    click_link "Add Expenses"
    select "Checking"
    fill_in "Description", :with => "Costco"
    fill_in "Amount", :with => "$150.00"
    click_button "Save"

    #Then the expenses should appear and my checking account should be $850.00
    page.find("#expenses").should have_content "Checking"
    page.find("#checking-balance").should have_content "$850.00"
  end

  scenario "Adding different types of expenses" do
    #Given no line items

    #When I add a Food and a Phone expense
    click_link "Add Expenses"
    fill_in "Description", :with => "Lunch"
    fill_in "Amount", :with => "$10.00"
    select "Food"
    click_button "Save"

    fill_in "Description", :with => "ATT Wireless"
    fill_in "Amount", :with => "$165.00"
    select "Phone"
    click_button "Save"

    #Then they should be categorized accordingly
    within("#expenses") do
      page.should have_content "Food"
      page.should have_content "Phone"
    end
  end

  scenario "Setting the date manually for expenses" do
    click_link "Add Expenses"
    date = Date.today.beginning_of_month + 5.days
    fill_in "Date", :with => date.strftime("%m/%-d")
    fill_in "Description", :with => "Stuff"
    fill_in "Amount", :with => "$123"
    click_button "Save"

    page.find("#expenses").should have_content date.strftime("%m/%-d")
  end

  scenario "Delete an expense" do
    #Given an expense
    click_link "Add Expenses"
    fill_in "Description", :with => "Shopping at the mall"
    fill_in "Amount", :with => "$25.00"
    click_button "Save"

    #And a negative credit card balance
    page.find("#credit-card-balance").should have_content "$-25.00"

    #When I click delete
    click_on "X"

    #Then it should disappear
    page.should_not have_content "Shopping at the mall"

    #And the account balance should be updated
    page.find("#credit-card-balance").should have_content "$0.00"
  end
end