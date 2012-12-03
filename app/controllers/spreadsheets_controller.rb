class SpreadsheetsController < ApplicationController
  def index
    @line_item = LineItem.new
    @line_item.account = params[:account] || "Credit Card"
  end
end