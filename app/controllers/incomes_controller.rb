class IncomesController < ApplicationController
  def new
  end

  def create
    Income.report(date, description, amount)
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
