class AccountsController < ApplicationController
  def index
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    account = Account.find(params[:id])
    account.set_balance(Money.parse(params[:account][:balance]))
    redirect_to accounts_url
  end
end