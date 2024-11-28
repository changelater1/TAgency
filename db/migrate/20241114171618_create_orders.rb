class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|

      t.string :status
      t.string :title
      t.text :description
      t.datetime :deadline
      t.bigint :performer_id
      t.bigint :customer_id

      t.timestamps
    end
  end
end
