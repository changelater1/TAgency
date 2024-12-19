class AddStatisticsFieldsForOrder < ActiveRecord::Migration[7.0]
  def change
    change_table :orders, bulk: true do |t|
      t.integer :symbols_count
      t.integer :words_count
      t.integer :symbols_count_without_spaces
    end
  end
end
