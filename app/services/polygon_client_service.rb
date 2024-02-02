class PolygonClientService

  def initialize(api_key)
    @api_key = api_key
    @base_uri = ENV['POLYGON_API_URL']
  end

  def fetch_stock_data(ticker, start_date, end_date)
    url = "#{@base_uri}/v2/aggs/ticker/#{ticker}/range/1/day/#{start_date}/#{end_date}"
    response = HTTParty.get(url, query: { apiKey: @api_key })

    if response.code >= 400
      raise "Error fetching data from Polygon: #{response.body}"
    end

    GetStockDto.new(response.parsed_response)
  end
end