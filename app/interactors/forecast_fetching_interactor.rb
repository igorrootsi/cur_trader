class ForecastFetchingInteractor
  # @param [ForecastRequest] forecast_request
  def initialize(forecast_request)
    @forecast_request = forecast_request
    @dto = ForecastResponseDTO.new
  end

  # @return [ForecastResponseDTO]
  def call
    fetch_previous_quotes
    generate_forecast

    @dto
  end

  def fetch_previous_quotes
    actor = PreviousRatesFetchingInteractor.new(@forecast_request)
    @dto.previous_quotes = actor.call
  end

  def generate_forecast
    ForecastGenerator.new(@forecast_request, @dto).call
  end
end
