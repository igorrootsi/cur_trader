class TradersController < ApplicationController
  def show
    @req = StockRequest.new({})
    @supported_currencies = %w[
      AUD​ BGN​ BRL​ CAD​ CHF​ CNY​ CZK​ DKK​ EUR​ GBP HKD​ HRK​ HUF​ IDR ILS
      INR JPY​ KRW MXN​ MYR NOK​ NZD PHP PLN RON RUB SEK SGD THB TRY
      USD ZAR
    ]
  end

  def create
    @supported_currencies = %w[
      AUD​ BGN​ BRL​ CAD​ CHF​ CNY​ CZK​ DKK​ EUR​ GBP HKD​ HRK​ HUF​ IDR ILS
      INR JPY​ KRW MXN​ MYR NOK​ NZD PHP PLN RON RUB SEK SGD THB TRY
      USD ZAR
    ]
    @req = StockRequest.new(stock_request_params)
    @req.validate
  end

  def stock_request_params
    params
      .require(:stock_request)
      .permit(:base_currency, :target_currency, :amount, :waiting_time)
  end
end
