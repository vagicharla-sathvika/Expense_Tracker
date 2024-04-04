class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :description
      t.string :reply
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
