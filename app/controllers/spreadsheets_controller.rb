class SpreadsheetsController < ApplicationController
  def index
    @balance = Money.new(0) - LineItem.all.inject(Money.new(0)) {|sum, x| sum + x.amount}
    @line_items = LineItem.this_month
  end
end