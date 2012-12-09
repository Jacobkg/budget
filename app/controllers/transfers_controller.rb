class TransfersController < ApplicationController
  def create
    Transfer.execute(params[:transfer][:description], Money.parse(params[:transfer][:amount]),
                     params[:transfer][:source_account], params[:transfer][:destination_account])
    redirect_to accounts_url
  end
end
