class ForecastGenerator
  # @param [ForecastRequest] forecast_request
  # @param [ForecastResponseDTO] dto
  def initialize(forecast_request, dto)
    @forecast_request = forecast_request
    @dto                = dto
  end

  def call
    generate_quotes
    @dto.ranks = @dto.quotes.max(3)
    @dto.base = @dto.quotes.first.rate

    @dto
  end

  def generate_quotes
    @dto.quotes = @dto.previous_quotes.reverse

    @dto.quotes.each_with_index do |quote, index|
      quote.date = coerce_day_to_week(Date.today + index.weeks)
    end
  end
end
