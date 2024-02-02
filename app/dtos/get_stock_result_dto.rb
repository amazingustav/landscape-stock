class GetStockResultDto
  attr_reader :volume, :volume_weighted_average_price, :open, :close, :high, :low, :timestamp, :number_of_items

  def initialize(result)
    @volume = result['v']
    @volume_weighted_average_price = result['vw']
    @open = result['o']
    @close = result['c']
    @high = result['h']
    @low = result['l']
    @timestamp = result['t']
    @number_of_items = result['n']
  end
end
