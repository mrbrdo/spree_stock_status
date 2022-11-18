Rails.application.config.to_prepare do
  Spree::StockItem.class_eval do
    after_save :update_arrivals

  protected
    def update_arrivals
      return unless variant
      # Only if stock was increased - meaning it "arrived"
      return unless count_on_hand_previously_changed?
      return if count_on_hand <= 0

      Spree::StockArrival.non_arrived.where(variant_id: variant.id).each(&:arrived!)
    end
  end
end
