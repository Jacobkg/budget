class LineItemsController < ApplicationController
  def create
    attributes = params[:line_item]
    LineItem.add_to_spreadsheet(Date.parse(params[:date_string]), attributes[:description], attributes[:category], Money.parse(attributes[:amount]), attributes[:account] )
    Account.by_name(attributes[:account]).deduct(Money.parse(attributes[:amount]))
    redirect_to root_url
  end
end
