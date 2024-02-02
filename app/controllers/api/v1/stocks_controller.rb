module Api
  module V1
    class StocksController < ::ApplicationController
      def show
        service = PolygonClientService.new(ENV['POLYGON_API_KEY'])
        stock_data = service.fetch_stock_data(params[:ticker], params[:start_date], params[:end_date])
        render json: stock_data
      rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
      end
    end
  end
end