class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :description
      t.integer :amount_in_cents
      t.date :date
      t.string :category
      t.string :account

      t.timestamps
    end
  end
end
