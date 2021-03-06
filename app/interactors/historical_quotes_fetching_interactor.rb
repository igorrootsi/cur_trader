require_relative './helpers'

class HistoricalQuotesFetchingInteractor
  attr_accessor :cached_quotes, :missing_weeks, :missing_quotes

  # @param [ForecastRequest] forecast_request
  def initialize(forecast_request)
    @forecast_request = forecast_request
  end

  def call
    fetch_previous_quotes
    find_missing_weeks
    fetch_missing_quotes

    combine_cached_and_fetched
  end

  def fetch_previous_quotes
    @cached_quotes = Quote.previous @forecast_request
  end

  def cached_weeks
    @cached_quotes.map { |quote| coerce_day_to_week(quote.date) }
  end

  def find_missing_weeks
    this_week = coerce_day_to_week
    range = ((this_week - @forecast_request.waiting_time.weeks)..this_week)

    @missing_weeks = range.each_with_object([]) do |day, accumulator|
      first_day_of_week = coerce_day_to_week(day)

      should_skip = accumulator.include?(first_day_of_week) ||
                    cached_weeks.include?(first_day_of_week)

      should_skip ? accumulator : accumulator.push(first_day_of_week)
    end
  end

  def fetch_missing_quotes
    if @missing_weeks.any?
      actor = ::Providers::FixerIo::FetchQuotes
              .new(@forecast_request, @missing_weeks)
      @missing_quotes = actor.call || []
    else
      @missing_quotes = []
    end
  end

  def combine_cached_and_fetched
    QuoteDecorator.decorate_collection(
      (@cached_quotes + @missing_quotes).sort_by(&:date),
      context: @forecast_request
    )
  end
end
