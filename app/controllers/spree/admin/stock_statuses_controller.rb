module Spree
  module Admin
    class StockStatusesController < ResourceController
      skip_before_action :load_resource, only: :create

      respond_to :html

      def create
        @stock_status = Spree::StockStatus.new(stock_status_params)
        @object = @stock_status
        invoke_callbacks(:create, :before)
        if @stock_status.save
          invoke_callbacks(:create, :after)
          flash[:success] = Spree.t(:successfully_created, resource: Spree.t(:stock_status))
          redirect_to spree.admin_stock_statuses_path
        else
          invoke_callbacks(:create, :fails)
          respond_with(@stock_status)
        end
      end

      def update
        invoke_callbacks(:update, :before)
        attributes = stock_status_params
        
        if @stock_status.update(attributes)
          invoke_callbacks(:update, :after)
          flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:stock_status))
          redirect_to spree.admin_stock_statuses_path
        else
          invoke_callbacks(:update, :fails)
          respond_with(@stock_status)
        end
      end

      private

      def scope
        Spree::StockStatus.order(:id)
      end

      def collection
        return @collection if @collection.present?

        @collection = scope
      end

      def stock_status_params
        params.require(:stock_status).permit!
      end
    end
  end
end
