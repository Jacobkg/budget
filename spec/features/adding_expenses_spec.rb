require "spec_helper"

feature "Adding Expenses" do

  scenario "Adding an expense to credit card updates the balance" do
    #Given a credit card balance of ($0)
    visit "/"
    page.find("#credit-card-balance").should have_content "$0.00"

    #When I add an expense against my credit card of $25
    fill_in "Description", :with => "Shopping at the mall"
    fill_in "Amount", :with => "$25.00"
    click_button "Save"

    #Then the expense should appear and my credit card balance should be ($25)
    page.should have_content "Shopping at the mall"
    page.find("#credit-card-balance").should have_content "$-25.00"
  end
end