require "spec_helper"

feature "Modifying Accounts" do

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

  scenario "Paying off credit card from checking" do
    #Given a credit card balance of -$100 and a checking balance of $1000
    Account.by_name("Credit Card").subtract(Money.new(10000))
    visit accounts_path
    page.should have_content "Credit Card $-100.00"
    page.should have_content "Checking $1,000.00"

    #When I transfer $100 from checking to credit card
    fill_in "Amount", :with => "$100"
    fill_in "Description", :with => "Pay off credit card"
    select "Checking", :from => "From"
    select "Credit Card", :from => "To"
    click_button "Transfer"

    #Then my credit card balance should be $0
    page.should have_content "Credit Card $0.00"
    page.should have_content "Checking $900.00"

    #And the transfer should be recorded
    page.should have_content "Pay off credit card"
  end

end
