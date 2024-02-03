class GetStockResponse
  attr_reader :max_price, :min_price, :average_price, :max_volume, :min_volume
  def initialize(max_price:, min_price:, average_price:, max_volume:, min_volume:)
    @max_price = max_price
    @min_price = min_price
    @average_price = average_price
    @max_volume = max_volume
    @min_volume = min_volume
  end

  # Converts the DTO to a hash suitable for JSON rendering
  def to_h
    {
      max_price: sprintf('%.2f', @max_price),
      min_price: sprintf('%.2f', @min_price),
      average_price: sprintf('%.2f', @average_price),
      max_volume: @max_volume.to_i,
      min_volume: @min_volume.to_i
    }
  end
end
