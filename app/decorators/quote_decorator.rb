# @attr [ForecastRequest] @context
class QuoteDecorator < ApplicationDecorator
  delegate_all

  def to_chart_item
    [year_week, @context.amount * rate]
  end

  def year_week
    "#{date.to_date.cwyear}/#{date.to_date.cweek}"
  end

  def rate
    rates[@context.target_currency]
  end

  def profit_loss(base)
    h.number_to_currency((rate - base) * @context.amount, unit: '')
  end

  def result
    h.number_to_currency(@context.amount * rate, unit: '')
  end

  # @param [QuoteDecorator] other
  def <=>(other)
    rate <=> other.rate
  end

  def rank(ranks)
    rank = ranks.index(self)

    rank + 1 if rank
  end
end
