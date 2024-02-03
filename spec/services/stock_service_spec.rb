require 'rails_helper'
require_relative '../support/mocked_polygon_response'

RSpec.describe StockService do
  describe '#get_stocks' do
    context 'when the API returns data' do
      let(:stock_data) {
        [
          { 'v' => 100, 'o' => 150.0, 'c' => 155.0, 'h' => 160.0, 'l' => 148.0, 't' => 123456, 'n' => 1 },
          { 'v' => 150, 'o' => 152.0, 'c' => 158.0, 'h' => 165.0, 'l' => 151.0, 't' => 123457, 'n' => 1 }
        ]
      }
      let(:mocked_api_response) { MockedPolygonResponse.data(custom_results: stock_data) }
      let(:mocked_service_response) { GetStockDto.new(JSON.parse(mocked_api_response)) }
      let(:polygon_client_service) { instance_double(PolygonClientService, fetch_stock_data: mocked_service_response) }
      let(:service) { StockService.new(polygon_client_service) }

      before do
        allow(PolygonClientService).to receive(:new).and_return(polygon_client_service)
      end

      let(:expected_response) {
        GetStockResponse.new(
          max_price: 165.0,
          min_price: 148.0,
          average_price: 156.5,
          max_volume: 150,
          min_volume: 100
        )
      }

      it 'returns the correct stock data summary' do
        get_stock_request = GetStockRequest.new(ticker: "AAPL", start_date: "2023-01-01", end_date: "2023-12-31")
        result = service.get_stocks(get_stock_request)

        expect(result.max_price).to eq(expected_response.max_price)
        expect(result.min_price).to eq(expected_response.min_price)
        expect(result.average_price).to eq(expected_response.average_price)
        expect(result.max_volume).to eq(expected_response.max_volume)
        expect(result.min_volume).to eq(expected_response.min_volume)
      end
    end

    context 'when the API returns no data' do
      let(:mocked_api_response) { MockedPolygonResponse.empty }
      let(:mocked_service_response) { GetStockDto.new(JSON.parse(mocked_api_response)) }
      let(:polygon_client_service) { instance_double(PolygonClientService, fetch_stock_data: mocked_service_response) }
      let(:service) { StockService.new(polygon_client_service) }

      before do
        allow(PolygonClientService).to receive(:new).and_return(polygon_client_service)
      end

      it 'raises NotFoundError' do
        get_stock_request = GetStockRequest.new(ticker: "TEST", start_date: "2023-01-01", end_date: "2023-12-31")

        expect {
          service.get_stocks(get_stock_request)
        }.to raise_error(NotFoundError)
      end
    end
  end
end
