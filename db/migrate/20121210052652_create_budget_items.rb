class CreateBudgetItems < ActiveRecord::Migration
  def change
    create_table :budget_items do |t|
      t.string :category
      t.integer :amount_in_cents

      t.timestamps
    end
  end
end
