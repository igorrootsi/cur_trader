require_relative './helpers'

class PreviousRatesFetchingInteractor
  attr_accessor :cached_rates, :missing_weeks, :missing_rates

  # @param [PredictionRequest] prediction_request
  def initialize(prediction_request)
    @prediction_request = prediction_request
  end

  def call
    fetch_previous_rates
    find_missing_weeks
    fetch_missing_rates

    combine_cached_and_fetched
  end

  def fetch_previous_rates
    @cached_rates = DayRate.previous @prediction_request
  end

  def cached_weeks
    @cached_rates.map { |quote| coerce_day_to_week(quote.date) }
  end

  def find_missing_weeks
    this_week = coerce_day_to_week
    range = ((this_week - @prediction_request.waiting_time.weeks)..this_week)

    @missing_weeks = range.each_with_object([]) do |day, accumulator|
      first_day_of_week = coerce_day_to_week(day)

      should_skip = accumulator.include?(first_day_of_week) ||
                    cached_weeks.include?(first_day_of_week)

      should_skip ? accumulator : accumulator.push(first_day_of_week)
    end
  end

  def fetch_missing_rates
    if @missing_weeks
      actor = ::Providers::FixerIo::FetchDayRates.new(@prediction_request)
      @missing_rates = actor.call(@missing_weeks) || []
    else
      @missing_weeks = []
    end
  end

  def combine_cached_and_fetched
    QuoteDecorator.decorate_collection(
      (@cached_rates + @missing_rates).sort_by(&:date),
      context: @prediction_request
    )
  end
end