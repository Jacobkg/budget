require "spec_helper"

feature "Editing Accounts" do

  scenario "edit credit card balance" do
    #Given a credit card balance of $0
    visit accounts_path
    page.should have_content "Credit Card $0.00"

    #When I change the balance to $-150
    find("#credit-card").click_link "Edit"
    fill_in "Balance", :with => "-$150"
    click_button "Save"

    #Then my credit card balance should be -$150
    page.should have_content "Credit Card $-150.00"
  end
end
