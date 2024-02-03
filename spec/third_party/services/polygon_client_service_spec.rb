require "rails_helper"
require_relative '../../support/mocked_polygon_response'

RSpec.describe PolygonClientService do
  let(:service) { PolygonClientService.new("fake_api_key") }

  describe '#fetch_stock_data' do
    it 'should fetch stock data for a given ticker and date range' do
      # Given
      ticker = 'AAPL'
      start_date = '2023-01-01'
      end_date = '2023-12-31'
      response_body = MockedPolygonResponse.data

      httparty_response = instance_double('HTTParty::Response', body: response_body, code: 200)

      allow(httparty_response).to receive(:parsed_response).and_return(JSON.parse(response_body))
      allow(HTTParty).to receive(:get).and_return(httparty_response)

      # When
      data = service.fetch_stock_data(ticker, start_date, end_date)

      # Then
      expect(data).to be_an_instance_of(GetStockDto)
    end

    it 'should fetch stock data when there is no results for a given ticker' do
      # Given
      ticker = 'TEST'
      start_date = '2023-01-01'
      end_date = '2023-12-31'
      response_body = MockedPolygonResponse.empty

      httparty_response = instance_double('HTTParty::Response', body: response_body, code: 200)

      allow(httparty_response).to receive(:parsed_response).and_return(JSON.parse(response_body))
      allow(HTTParty).to receive(:get).and_return(httparty_response)

      # When
      data = service.fetch_stock_data(ticker, start_date, end_date)

      # Then
      expect(data).to be_an_instance_of(GetStockDto)
    end
  end
end