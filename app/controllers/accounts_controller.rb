class AccountsController < ApplicationController
  def index
  end

  def new
  end

  def create
    Account.add_account(params[:account][:name])
    redirect_to accounts_url
  end

  def edit
    @account = Account.by_id(params[:id])
  end

  def update
    account = Account.by_id(params[:id])
    account.set_balance(Money.parse(params[:account][:balance]))
    redirect_to accounts_url
  end
end