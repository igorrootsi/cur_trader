class ForecastRequestsController < ApplicationController
  def index
    @forecast_requests = current_user.forecast_requests
  end

  def show
    @forecast_request = current_user.forecast_requests.find(params[:id])
  end

  def destroy
    current_user.forecast_requests.destroy(params[:id])

    redirect_to forecast_requests_path
  end
end