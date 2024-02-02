require "rails_helper"
require_relative '../support/mocked_polygon_response'

RSpec.describe PolygonClientService do
  describe '#fetch_stock_data' do
    let(:ticker) { 'AAPL' }
    let(:start_date) { '2023-01-01' }
    let(:end_date) { '2023-12-31' }
    let(:base_uri) { ENV['POLYGON_API_URL'] }
    let(:path) { "/v2/aggs/ticker/#{ticker}/range/1/day/#{start_date}/#{end_date}" }
    let(:full_uri) { "#{base_uri}#{path}" }
    let(:response_body) { MockedPolygonResponse.data(ticker: ticker, start_date: start_date, end_date: end_date) }

    before do
      response = instance_double('HTTParty::Response', body: response_body, code: 200)

      allow(response).to receive(:parsed_response).and_return(JSON.parse(response_body))
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it 'should fetch stock data for a given ticker and date range' do
      service = PolygonClientService.new("fake_api_key")
      data = service.fetch_stock_data(ticker, start_date, end_date)

      expect(data).to be_an_instance_of(GetStockDto)
    end
  end
end