class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :balance_in_cents, :default => 0

      t.timestamps
    end
  end
end
