Rails.application.config.to_prepare do
  Spree::Product.class_eval do
    belongs_to :stock_status, class_name: 'Spree::StockStatus'
  end
end