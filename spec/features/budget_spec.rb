require "spec_helper"

feature "Budget" do

  scenario "Set a budget" do
    #Given no budget has been set
    visit "/"
    click_link "Budget"
    page.should have_content "Rent $0.00"

    #When I set the budget for Rent
    page.find('#rent').click_link "Edit"
    page.find('#rent').fill_in "budget_item_amount", :with => "$1485.00"
    click_button "Save"

    #Then spreadsheet should show amounts remaining
    page.should have_content "Rent $1,485.00"
  end

  scenario "Add a new monthly budget category" do
    visit budget_items_path

    click_link "New Category"
    fill_in "Category", :with => "FooBar"
    select "Monthly"
    click_button "Save"

    page.find('#monthly').should have_content "FooBar $0.00"
  end

  scenario "Add a new yearly budget category" do
    visit budget_items_path

    click_link "New Category"
    fill_in "Category", :with => "Automotive"
    select "Yearly"
    click_button "Save"

    page.find('#yearly').should have_content "Automotive $0.00"
  end

end
