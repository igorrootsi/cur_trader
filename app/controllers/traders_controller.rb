# @attr [User] current_user
class TradersController < ApplicationController
  def show
    @forecast_request = current_user.forecast_requests.build
  end
end
