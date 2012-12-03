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

  scenario "Adding different types of expenses" do
    #Given no line items

    #When I add a Food and a Phone expense
    visit "/"
    fill_in "Description", :with => "Lunch"
    fill_in "Amount", :with => "$10.00"
    select "Food"
    click_button "Save"

    fill_in "Description", :with => "ATT Wireless"
    fill_in "Amount", :with => "$165.00"
    select "Phone"
    click_button "Save"

    #Then they should be categorized accordingly
    within("#line-items") do
      page.should have_content "Food"
      page.should have_content "Phone"
    end
  end
end