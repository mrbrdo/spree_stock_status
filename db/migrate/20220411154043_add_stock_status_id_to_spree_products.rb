class AddStockStatusIdToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :spree_products, :stock_status, null: true, foreign_key: { to_table: :spree_stock_statuses }
  end
end
