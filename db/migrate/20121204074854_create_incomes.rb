class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :description
      t.integer :amount_in_cents
      t.date :date

      t.timestamps
    end
  end
end
