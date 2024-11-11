module Spree
  module Admin
    class StockArrivalsController < ResourceController
      skip_before_action :load_resource, only: :create

      respond_to :html

      def create
        variant = Spree::Variant.find(stock_arrival_params[:variant_id])
        if stock_arrival_params[:arriving_from].present?
          arriving_to = stock_arrival_params[:arriving_to].presence
          arriving_to = Date.parse(arriving_to) if arriving_to
          @stock_status = Spree::StockStatus.new(
            arriving_from: Date.parse(stock_arrival_params[:arriving_from]),
            arriving_to: arriving_to)
        elsif stock_arrival_params[:stock_status_id].present?
          @stock_status = Spree::StockStatus.find(stock_arrival_params[:stock_status_id])
        end
        raise ActionController::InvalidAuthenticityToken unless @stock_status
        previous_stock_status_id = variant.product.stock_status_id
        if previous_stock_status_id == @stock_status.id
          previous_stock_status_id =
            Spree::StockArrival.joins(:variant).
            where(spree_variants: { product_id: variant.product.id }).
            order(created_at: :desc).limit(1).
            pluck(:previous_stock_status_id).first
        end
        if @stock_status.save && variant.product.update(stock_status: @stock_status)
          Spree::StockArrival.create!(
            variant: variant,
            previous_backorderable: variant.backorderable?,
            previous_stock_status_id: previous_stock_status_id,
            arrival_stock_status_id: @stock_status.id
          )
          variant.stock_items.each do |stock_item|
            stock_item.update!(backorderable: true)
          end
          variant.touch # TODO: this invalidates cache for now
          flash[:success] = Spree.t(:successfully_created, resource: Spree.t(:stock_status))
          redirect_back fallback_location: edit_admin_product_path(variant.product.id)
        else
          invoke_callbacks(:create, :fails)
          respond_with(@stock_status)
        end
      end

      private

      def scope
        Spree::StockArrival.order(:id)
      end

      def collection
        return @collection if @collection.present?

        @collection = scope
      end

      def stock_arrival_params
        params.require(:stock_arrival).permit!
      end
    end
  end
end
