class MockedPolygonResponse
  def self.data
    {
      "status" => "OK",
      "ticker" => "TEST",
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

  def self.empty
    {
      "status" => "OK",
      "ticker" => "INVALID_TICKER",
      "queryCount" => 0,
      "resultsCount" => 0,
      "adjusted" => true,
      "request_id": "request_id"
    }.to_json
  end
end
