class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :department
      t.string :employment_status
      t.string :email
      t.boolean :admin_status

      t.timestamps
    end
  end
end
