module Spree
  class StockStatus < ActiveRecord::Base
    translates :name, backend: :table
    
    has_many :products, class_name: 'Spree::Product'
  end
end