class IncomesController < ApplicationController
  def new
  end

  def create
    Income.add_to_spreadsheet(date, description, amount)
    Account.by_name("Checking").add(amount)
    redirect_to new_income_url
  end

  private

    def date
      Date.parse(params[:income][:date_string])
    end

    def description
      params[:income][:description]
    end

    def amount
      Money.parse(params[:income][:amount])
    end
end
