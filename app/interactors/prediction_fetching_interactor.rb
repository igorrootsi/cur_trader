class PredictionFetchingInteractor
  # @param [PredictionRequest] prediction_request
  def initialize(prediction_request)
    @prediction_request = prediction_request
    @dto = PredictionResponseDTO.new
  end

  # @return [PredictionResponseDTO]
  def call
    fetch_previous_quotes
    generate_prediction

    @dto
  end

  def fetch_previous_quotes
    actor = PreviousRatesFetchingInteractor.new(@prediction_request)
    @dto.previous_quotes = actor.call
  end

  def generate_prediction
    PredictionGenerator.new(@prediction_request, @dto).call
  end
end