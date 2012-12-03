class LineItemsController < ApplicationController
  def create
    attributes = params[:line_item]
    LineItem.add_to_spreadsheet(Date.today, attributes[:description], attributes[:category], Money.parse(attributes[:amount]), attributes[:account] )
    redirect_to root_url
  end
end
