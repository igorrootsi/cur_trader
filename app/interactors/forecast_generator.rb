class ForecastGenerator
  # @param [ForecastRequest] forecast_request
  # @param [ForecastResponseDTO] dto
  def initialize(forecast_request, dto)
    @forecast_request = forecast_request
    @dto              = dto
  end

  def call
    generate_quotes
  end

  def generate_quotes
    quotes = @dto.previous_quotes.reverse

    quotes.each_with_index do |quote, index|
      quote.date = coerce_day_to_week(Date.today + index.weeks)
    end
  end
end
