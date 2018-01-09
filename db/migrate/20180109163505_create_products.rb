class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :amount
      t.string :email
      t.string :user_name

      t.timestamps
    end
  end
end
