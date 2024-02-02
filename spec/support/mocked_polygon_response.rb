class MockedPolygonResponse
  def self.data(ticker: "AAPL", start_date: "2023-01-01", end_date: "2023-12-31")
    {
      "status" => "OK",
      "ticker" => ticker,
      "queryCount" => 1,
      "resultsCount" => 1,
      "adjusted" => true,
      "results" => [
        {
          "v" => 100,
          "vw" => 100,
          "o" => 100,
          "c" => 100,
          "h" => 100,
          "l" => 100,
          "t" => 100,
          "n" => 100
        }
      ],
      "request_id": "request_id"
    }.to_json
  end
end
