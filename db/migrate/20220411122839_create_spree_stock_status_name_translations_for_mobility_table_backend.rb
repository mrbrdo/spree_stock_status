class CreateSpreeStockStatusNameTranslationsForMobilityTableBackend < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_stock_status_translations do |t|
      # Translated attribute(s)
      t.string :name, null: false

      t.string  :locale, null: false
      t.references :spree_stock_status, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spree_stock_status_translations, :locale, name: :index_stock_status_translations_on_locale
    add_index :spree_stock_status_translations, [:spree_stock_status_id, :locale], name: :index_stock_status_translations_on_stock_status_id_and_locale, unique: true

  end
end
