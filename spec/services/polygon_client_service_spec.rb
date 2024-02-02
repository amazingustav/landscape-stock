require "rails_helper"

RSpec.describe PolygonClientService do
  describe '#fetch_stock_data' do
    let(:ticker) { 'AAPL' }
    let(:start_date) { '2023-01-01' }
    let(:end_date) { '2023-12-31' }

    it 'should fetch stock data for a given ticker and date range' do
      response_body = { data: 'value' }.to_json
      response = instance_double('HTTParty::Response', body: response_body, code: 200)

      allow(HTTParty).to receive(:get).and_return(response)

      service = PolygonClientService.new
      data = service.fetch_stock_data(ticker, start_date, end_date)

      expect(data).to be_present
      expect(data).to eq(JSON.parse(response.body))
    end
  end
end