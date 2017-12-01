class TradersController < ApplicationController
  def show
    @req = PredictionRequest.new({})

    @supported_currencies = PredictionRequest.supported_currencies
  end

  def create
    @supported_currencies = PredictionRequest.supported_currencies

    @req = PredictionRequest.new(prediction_request_params)
    @req.validate
    @dto = PredictionFetchingInteractor.new(@req).call
  end

  def prediction_request_params
    params
      .require(:prediction_request)
      .permit(:base_currency, :target_currency, :amount, :waiting_time)
  end
end
