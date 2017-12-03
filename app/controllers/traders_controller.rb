# @attr [User] current_user
class TradersController < ApplicationController
  def show
    @req = current_user.prediction_requests.build
  end
end
