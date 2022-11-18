module Spree
  class StockArrival < ActiveRecord::Base
    belongs_to :variant, class_name: 'Spree::Variant'
    belongs_to :arrival_stock_status, class_name: 'Spree::StockStatus'
    scope :arrived, -> { where(arrived: true) }
    scope :non_arrived, -> { where(arrived: false) }

    def arrived!
      return if arrived
      variant.product.update!(
        stock_status_id: self.previous_stock_status_id,
      )
      variant.stock_items.each do |stock_item|
        stock_item.update!(backorderable: self.previous_backorderable)
      end
      update!(arrived: true)
      variant.touch # TODO: this invalidates cache for now
    end
  end
end
