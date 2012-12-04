class IncomesController < ApplicationController
  def new
  end

  def create
    Income.add_to_spreadsheet(params[:income][:description], Money.parse(params[:income][:amount]))
    Account.by_name("Checking").add(Money.parse(params[:income][:amount]))
    redirect_to new_income_url
  end
end
