require 'rails_helper'
require_relative '../../../support/mocked_polygon_response'

RSpec.describe Api::V1::StocksController, type: :controller do
  describe 'GET #show' do
    let(:mocked_api_response) { MockedPolygonResponse.data }
    let(:mocked_service_response) { GetStockDto.new(JSON.parse(mocked_api_response)) }
    let(:stock_service) { instance_double(StockService, get_stocks: mocked_service_response) }

    before do
      allow(StockService).to receive(:new).and_return(stock_service)
    end

    it 'should return a success response for valid input' do
      get :show, params: { ticker: 'AAPL', start_date: '2020-01-01', end_date: '2020-01-31' }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(mocked_service_response.to_json)
    end

    it 'should return a bad request response if start_date is greater than end_date or dates are in the future' do
      get :show, params: { ticker: 'AAPL', start_date: one_year_in_future, end_date: '2020-01-31' }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to eq("Start date must be before end date, Dates cannot be in the future")
    end
  end

  private

  def one_year_in_future
    (Date.today + 1.year).to_s
  end
end
