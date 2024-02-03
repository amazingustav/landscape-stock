class MockedPolygonResponse
  def self.data(custom_results: nil)
    results = custom_results || [
      {
        "v" => 25,
        "vw" => 200,
        "o" => 10,
        "c" => 5,
        "h" => 10000,
        "l" => 300,
        "t" => 400,
        "n" => 500
      },
      {
        "v" => 1200,
        "vw" => 4400,
        "o" => 5500,
        "c" => 6600,
        "h" => 7700,
        "l" => 8800,
        "t" => 9900,
        "n" => 10
      }
    ]

    {
      "status" => "OK",
      "ticker" => "TEST",
      "queryCount" => 1,
      "resultsCount" => 1,
      "adjusted" => true,
      "results" => results,
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
