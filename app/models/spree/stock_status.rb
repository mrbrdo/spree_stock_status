module Spree
  class StockStatus < ActiveRecord::Base
    extend Mobility
    translates :name, backend: :table
    
    has_many :products, class_name: 'Spree::Product'
    
    # Allow assignment of different names per locale, e.g. name = { 'en' => 'Name', ... }
    def name=(value)
      super(value) unless value.kind_of?(Hash)
      
      value.each_pair do |locale, new_name|
        Mobility.with_locale(locale) { super(new_name) }
      end
    end
  end
end