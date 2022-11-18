class CreateSpreeStockArrivals < ActiveRecord::Migration[6.1]
  def change
    change_table(:spree_stock_statuses) do |t|
      t.column :arriving_from, :date
      t.column :arriving_to, :date
    end

    create_table :spree_stock_arrivals do |t|
      t.references :variant, foreign_key: { to_table: :spree_variants }, null: false
      t.boolean :previous_backorderable, null: false
      t.references :previous_stock_status, foreign_key: { to_table: :spree_stock_statuses }, null: true
      t.references :arrival_stock_status, foreign_key: { to_table: :spree_stock_statuses }, null: false
      t.boolean :arrived, default: false, null: false

      t.timestamps
    end
  end
end
