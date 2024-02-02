module Api
  module V1
    class StocksController < ::ApplicationController
      def show
        get_stock_request = GetStockRequest.new(
          ticker: params[:ticker],
          start_date: params[:start_date],
          end_date: params[:end_date]
        )

        get_stock_request.validate!

        service = StockService.new
        data = service.get_stocks(get_stock_request)

        render json: data
      rescue ArgumentError => e
        render json: { error: e.message }, status: :bad_request
      rescue StandardError => e
        Rails.logger.error "Error while accessing GetStocks request: #{e.message}"
        Rails.logger.error e.backtrace&.join("\n")

        render json: { error: "An unexpected error occurred" }, status: :internal_server_error
      end
    end
  end
end