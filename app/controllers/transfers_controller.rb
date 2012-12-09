class TransfersController < ApplicationController
  def create
    Transfer.execute(Date.parse(params[:transfer][:date_string]), params[:transfer][:description], Money.parse(params[:transfer][:amount]),
                     params[:transfer][:source_account], params[:transfer][:destination_account])
    redirect_to accounts_url
  end
end
