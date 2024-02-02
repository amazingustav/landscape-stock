require 'httparty'

class PolygonClientService
  def fetch_stock_data(ticker, start_date, end_date)
    api_key = ENV['POLYGON_API_KEY']
    url = "https://api.polygon.io/v2/aggs/ticker/#{ticker}/range/1/day/#{start_date}/#{end_date}?apiKey=#{api_key}"
    response = HTTParty.get(url)

    if response.code == 200
      JSON.parse(response.body)
    else
      raise "Error fetching data from Polygon: #{response.body}"
    end
  end
end