class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :description
      t.integer :amount_in_cents
      t.date :date

      t.timestamps
    end
  end
end
