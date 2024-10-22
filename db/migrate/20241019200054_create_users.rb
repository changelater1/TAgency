class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :country
      t.decimal :pricing # ne mesto dlya etogo
      t.text :contacts # ,ozhno bez etogo tozhe
      t.integer :role, null: false, default: 0
      t.timestamps
    end
  end
end
