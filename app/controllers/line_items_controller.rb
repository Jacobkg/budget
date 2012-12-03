class LineItemsController < ApplicationController
  def create
    attributes = params[:line_item]
    LineItem.add_to_spreadsheet(Date.today, attributes[:description], Money.parse(attributes[:amount]), attributes[:category] )
    redirect_to root_url
  end
end
