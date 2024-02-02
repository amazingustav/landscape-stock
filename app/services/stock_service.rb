class StockService
  def initialize(polygon_client_service = PolygonClientService.new(ENV['POLYGON_API_KEY']))
    @polygon_client_service = polygon_client_service
  end

  def get_stocks(get_stock_request)
    @polygon_client_service.fetch_stock_data(
      get_stock_request.ticker,
      get_stock_request.start_date,
      get_stock_request.end_date
    )
  end
end
