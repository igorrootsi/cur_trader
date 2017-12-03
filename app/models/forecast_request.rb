class ForecastRequest < ApplicationRecord
  def self.supported_currencies
    %w[
      AUD BGN BRL CAD CHF CNY CZK DKK EUR GBP HKD HRK HUF IDR ILS
      INR JPY KRW MXN MYR NOK NZD PHP PLN RON RUB SEK SGD THB TRY
      USD ZAR
    ]
  end

  belongs_to :user, optional: true
  validates :base_currency,
            :target_currency,
            :amount,
            :waiting_time,
            presence: true

  validate :base_and_target_currencies_are_same

  def base_and_target_currencies_are_same
    return unless base_currency == target_currency

    errors.add(:target_currency, 'must be different to base currency')
  end
end