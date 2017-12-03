# @attr [User] current_user
class TradersController < ApplicationController
  def show
    @req = current_user.forecast_requests.build
  end
end
