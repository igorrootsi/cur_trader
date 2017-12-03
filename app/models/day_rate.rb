class DayRate < ApplicationRecord
  validates :base_currency, :date, :provider, :rates, presence: true
  validates :date, uniqueness: { scope: :base_currency }

  # @param [ForecastRequest] forecast_request
  def self.previous(forecast_request)
    week = (Date.today - forecast_request.waiting_time.weeks).beginning_of_week
    currency = forecast_request.base_currency

    where('date >= ? AND base_currency = ?', week, currency)
  end
end