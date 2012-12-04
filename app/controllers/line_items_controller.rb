class LineItemsController < ApplicationController

  def new
  end

  def create
    LineItem.add_to_spreadsheet(date, description, category, amount, account_name)
    Account.by_name(account_name).deduct(amount)
    redirect_to new_line_item_url
  end

  private

    def date
      Date.parse(params[:line_item][:date_string])
    end

    def description
      params[:line_item][:description]
    end

    def category
      params[:line_item][:category]
    end

    def amount
      Money.parse(params[:line_item][:amount])
    end

    def account_name
      params[:line_item][:account]
    end
end
