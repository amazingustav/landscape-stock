class StockService
  def initialize(polygon_client_service = PolygonClientService.new(ENV['POLYGON_API_KEY']))
    @polygon_client_service = polygon_client_service
  end

  def get_stocks(get_stock_request)
    stock_data = @polygon_client_service.fetch_stock_data(
      get_stock_request.ticker,
      get_stock_request.start_date,
      get_stock_request.end_date
    )

    stock_list = stock_data.results

    if stock_list.empty?
      raise NotFoundError, "No stock data found for ticker #{get_stock_request.ticker}"
    end

    max_price = stock_list.map(&:high).max
    min_price = stock_list.map(&:low).min
    max_volume = stock_list.map(&:volume).max&.to_i || 0
    min_volume = stock_list.map(&:volume).min&.to_i || 0
    average_price = if stock_list.any?
                      stock_list.map(&:close).sum / stock_list.size.to_f
                    else
                      0
                    end

    GetStockResponse.new(
      max_price: max_price,
      min_price: min_price,
      average_price: average_price.round(2),
      max_volume: max_volume,
      min_volume: min_volume
    )
  end
end
