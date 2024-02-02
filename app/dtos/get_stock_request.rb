class GetStockRequest
  include ActiveModel::Validations

  attr_accessor :ticker, :start_date, :end_date

  validates :ticker, presence: true
  validate :date_format_correct, :start_date_before_end_date, :dates_not_in_future

  def initialize(ticker:, start_date:, end_date:)
    @ticker = ticker
    @start_date = start_date
    @end_date = end_date
  end

  def validate!
    raise ArgumentError.new(errors.full_messages.join(', ')) unless valid?
  end

  private

  def date_format_correct
    unless start_date =~ /\d{4}-\d{2}-\d{2}/ && end_date =~ /\d{4}-\d{2}-\d{2}/
      errors.add(:base, 'Dates must be in the format YYYY-MM-DD')
    end
  end

  def start_date_before_end_date
    if Date.parse(start_date) >= Date.parse(end_date)
      errors.add(:base, 'Start date must be before end date')
    end
  end

  def dates_not_in_future
    if Date.parse(start_date) > Date.today || Date.parse(end_date) > Date.today
      errors.add(:base, 'Dates cannot be in the future')
    end
  end
end
