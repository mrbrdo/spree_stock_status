module Spree
  class StockStatus < ActiveRecord::Base
    extend Mobility
    translates :name, backend: :table

    has_many :products, class_name: 'Spree::Product'

    scope :stock_arrivals, -> { where.not(arriving_from: nil) }

    def self.non_stock_arrivals(include_id: nil)
      if include_id
        where('spree_stock_statuses.arriving_from IS NULL OR spree_stock_statuses.id = ?', include_id)
      else
        where(arriving_from: nil)
      end
    end

    # Allow assignment of different names per locale, e.g. name = { 'en' => 'Name', ... }
    def name=(value, options = {})
      return super(value, options) unless value.kind_of?(Hash)

      value.each_pair do |locale, new_name|
        Mobility.with_locale(locale) { super(new_name) }
      end
    end

    def name
      if arriving_from
        super || display_arrival_dates
      else
        super
      end
    end

    def display_arrival_dates
      text = arriving_from.strftime('%d.%m.%Y')
      text += " - #{arriving_to.strftime('%d.%m.%Y')}" if arriving_to
      text
    end
  end
end
