class DayRate < ApplicationRecord
  validates :base_currency, :date, :provider, :rates, presence: true
  validates :date, uniqueness: { scope: :base_currency }

  def self.previous(days, prediction_request)
    where 'date >= ? AND base_currency = ?',
          Date.today - days,
          prediction_request.base_currency
  end
end