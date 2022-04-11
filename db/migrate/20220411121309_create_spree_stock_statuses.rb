class CreateSpreeStockStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_stock_statuses do |t|
      t.string :code

      t.timestamps
    end
  end
end
