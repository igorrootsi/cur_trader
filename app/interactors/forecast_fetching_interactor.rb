class ForecastFetchingInteractor
  attr_accessor :forecast_request, :dto

  # @param [ForecastRequest] forecast_request
  def initialize(forecast_request)
    @forecast_request = forecast_request
    @dto = ForecastResponseDTO.new
  end

  # @return [ForecastResponseDTO]
  def call
    fetch_previous_quotes
    generate_forecast

    generate_ranks
    generate_base

    @dto
  end

  def generate_ranks
    @dto.ranks = @dto.quotes.max(3)
  end

  def generate_base
    @dto.base  = @dto.quotes.first.rate
  end

  def fetch_previous_quotes
    actor = HistoricalQuotesFetchingInteractor.new(@forecast_request)
    @dto.previous_quotes = actor.call
  end

  def generate_forecast
    actor = ForecastGenerator.new(@forecast_request, @dto)
    @dto.quotes = actor.call
  end
end
