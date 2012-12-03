class LineItemsController < ApplicationController
  def create
    LineItem.add_to_spreadsheet(params[:line_item][:description], Money.parse(params[:line_item][:amount]), Date.today)
    redirect_to root_url
  end
end
