class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.date :date
      t.string :description
      t.integer :amount_in_cents
      t.string :source_account
      t.string :destination_account

      t.timestamps
    end
  end
end
