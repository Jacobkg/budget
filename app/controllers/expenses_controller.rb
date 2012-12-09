class ExpensesController < ApplicationController

  def new
  end

  def create
    Expense.report(date, description, category, amount, account_name)
    redirect_to new_expense_url
  end

  def destroy
    expense = Expense.by_id(params[:id])
    Account.by_name(expense.account).add(expense.amount)
    expense.destroy
    redirect_to(:back)
  end

  private

    def date
      Date.parse(params[:expense][:date_string])
    end

    def description
      params[:expense][:description]
    end

    def category
      params[:expense][:category]
    end

    def amount
      Money.parse(params[:expense][:amount])
    end

    def account_name
      params[:expense][:account]
    end
end
