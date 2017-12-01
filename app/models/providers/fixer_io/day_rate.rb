class Providers::FixerIo::DayRate
  attr_accessor :base_currency, :date, :rates, :provider

  def initialize(args)
    @provider      = 'FixerIo'
    @base_currency = args['base']
    @date          = args['date']
    @rates         = args['rates']
  end

  def save
    ::DayRate.create(
      provider:      @provider,
      base_currency: @base_currency,
      date:          @date,
      rates:         @rates
    )
  end
end