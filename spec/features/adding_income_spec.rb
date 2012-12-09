require "spec_helper"

feature "Adding Income" do

  background do
    visit "/"
  end

  scenario "Adding income to checking account updates the balance" do
    #Given a checking balance of $1000
    page.find("#checking-balance").should have_content "$1,000.00"

    #When I add income to the checking account of $500
    click_link "Add Income"
    fill_in "Description", :with => "Christmas Bonus"
    fill_in "Amount", :with => "$500.00"
    click_button "Save"

    #Then I the income should appear and my credit card balance should be $1500
    page.should have_content "Christmas Bonus"
    page.find("#checking-balance").should have_content "$1,500.00"
  end

  scenario "Setting the date manually for expenses" do
    click_link "Add Income"
    date = Date.today.beginning_of_month + 5.days
    fill_in "Date", :with => date.strftime("%m/%-d")
    fill_in "Description", :with => "Stuff"
    fill_in "Amount", :with => "$123"
    click_button "Save"

    page.find("#income").should have_content date.strftime("%m/%-d")
  end

end