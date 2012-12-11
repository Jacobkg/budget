class BudgetItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
    BudgetItem.add_to_budget(params[:budget_item][:category], params[:budget_item][:period])
    redirect_to budget_items_url
  end

  def edit
    @budget_item = BudgetItem.find(params[:id])
  end

  def update
    budget_item = BudgetItem.find(params[:id])
    budget_item.set_amount(Money.parse(params[:budget_item][:amount]))
    redirect_to budget_items_url
  end

end