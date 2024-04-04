class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.date :date
      t.string :description
      t.integer :amount
      t.integer :invoice_number
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
