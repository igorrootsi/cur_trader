# @attr [User] current_user
class TradersController < ApplicationController
  def show
    @req = PredictionRequest.new({})

    @supported_currencies = PredictionRequest.supported_currencies

    @saved_requests = current_user.prediction_requests
  end

  def create
    @supported_currencies = PredictionRequest.supported_currencies

    if params[:commit] == 'Find and save'
      @req = current_user
             .prediction_requests
             .create!(prediction_request_params)
    else
      @req = PredictionRequest.new(prediction_request_params)
      @req.validate
    end

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
