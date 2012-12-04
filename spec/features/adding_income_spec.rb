require "spec_helper"

feature "Adding Income" do

  scenario "Adding income to checking account updates the balance" do
    #Given a checking balance of $1000
    visit "/"
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

end