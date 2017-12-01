class DayRate < ApplicationRecord
  validates :base_currency, :date, :provider, :rates, presence: true
  validates :date, uniqueness: { scope: :base_currency }

  # @param [PredictionRequest] prediction_request
  def self.previous(prediction_request)
    week = (Date.today - prediction_request.waiting_time.weeks).beginning_of_week
    currency = prediction_request.base_currency

    where('date >= ? AND base_currency = ?', week, currency)
  end
end