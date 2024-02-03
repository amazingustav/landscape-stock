require 'rails_helper'
require_relative '../../../support/mocked_polygon_response'

RSpec.describe Api::V1::StocksController, type: :controller do
  describe 'GET #show' do
    let(:mocked_api_response) { MockedPolygonResponse.data }
    let(:mocked_service_response) { GetStockDto.new(JSON.parse(mocked_api_response)) }
    let(:polygon_client_service) { instance_double(PolygonClientService, fetch_stock_data: mocked_service_response) }

    before do
      allow(PolygonClientService).to receive(:new).and_return(polygon_client_service)
    end

    it 'should return a success response for valid input' do
      get_stock_response = GetStockResponse.new(
        max_price: 10000.00,
        min_price: 300.00,
        average_price: 3302.50,
        max_volume: 1200,
        min_volume: 25
      ).to_h

      get :show, params: { ticker: 'AAPL', start_date: '2020-01-01', end_date: '2020-01-31' }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(get_stock_response.to_json)
    end

    it 'should return a bad request response if start_date is greater than end_date or dates are in the future' do
      get :show, params: { ticker: 'AAPL', start_date: one_year_in_future, end_date: '2020-01-31' }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to eq("Start date must be before end date, Dates cannot be in the future")
    end

    it 'should return not found response if ticker does not exists' do
      mocked_api_response = MockedPolygonResponse.empty
      mocked_service_response = GetStockDto.new(JSON.parse(mocked_api_response))
      polygon_client_service = instance_double(PolygonClientService, fetch_stock_data: mocked_service_response)

      allow(PolygonClientService).to receive(:new).and_return(polygon_client_service)

      get :show, params: { ticker: 'TEST', start_date: '2020-01-01', end_date: '2020-01-31' }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq("No stock data found for ticker TEST")
    end
  end

  private

  def one_year_in_future
    (Date.today + 1.year).to_s
  end
end
