class GetStockDto
  attr_reader :ticker, :query_count, :results_count, :adjusted, :results

  def initialize(data)
    @ticker = data['ticker']
    @query_count = data['queryCount']
    @results_count = data['resultsCount']
    @adjusted = data['adjusted']
    @results = data['results'].map { |result| GetStockResultDto.new(result) }
  end
end
