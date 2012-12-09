class Transfer < ActiveRecord::Base
  attr_accessible

  def amount
    Money.new(amount_in_cents)
  end

  def self.execute(date, description, amount, source_account, destination_account)
    create_transfer(date, description, amount, source_account, destination_account)
    Account.by_name(source_account).subtract(amount)
    Account.by_name(destination_account).add(amount)
  end

  private

    def self.create_transfer(date, description, amount, source_account, destination_account)
      transfer = Transfer.new
      transfer.date = date
      transfer.description = description
      transfer.amount_in_cents = amount.cents
      transfer.source_account = source_account
      transfer.destination_account = destination_account
      transfer.save!
    end

end
