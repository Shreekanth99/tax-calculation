class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_code, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, array: true, default: []
      t.date :doj, null: false
      t.float :salary, null: false

      t.timestamps
    end
  end
end
