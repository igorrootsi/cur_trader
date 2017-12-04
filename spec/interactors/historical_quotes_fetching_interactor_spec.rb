require 'active_support/core_ext/numeric/time'
require 'spec_helper'
require_relative '../../app/interactors/historical_quotes_fetching_interactor'

# rubocop:disable Metrics/BlockLength
describe HistoricalQuotesFetchingInteractor do
  let(:forecast_request) do
    double :forecastRequest, waiting_time: 1
  end

  subject { HistoricalQuotesFetchingInteractor.new(forecast_request) }

  let(:cached_quotes)  { [double(:Quote1, date: Date.today)] }
  let(:missing_quotes) do
    [double(:Quote2, date: Date.today.beginning_of_week - 1.week)]
  end
  let(:missing_weeks) { [Date.today.beginning_of_week - 1.week] }

  let(:combined) { [missing_quotes.first, cached_quotes.first] }

  describe '.call' do
    before do
      is_expected.to receive(:fetch_previous_quotes)
      is_expected.to receive(:find_missing_weeks)
      is_expected.to receive(:fetch_missing_quotes)
      is_expected.to receive(:combine_cached_and_fetched) { combined }
    end

    it 'it should return array of previous quotes' do
      expect(subject.call).to be(combined)
    end
  end

  describe '.fetch_missing_quotes' do
    let(:fetcher_instance) { double('::Providers::FixerIo::FetchQuotes') }
    let(:fetcher) do
      class_double('::Providers::FixerIo::FetchQuotes').as_stubbed_const
    end

    context 'all quotes are cached' do
      before do
        subject.missing_weeks = []
        expect(fetcher).to_not receive(:new)

        subject.fetch_missing_quotes
      end

      its(:missing_quotes) { is_expected.to eq [] }
    end

    context 'not all quotes are cached' do
      before do
        expect(fetcher).to receive(:new).with(forecast_request, missing_weeks) do
          fetcher_instance
        end

        expect(fetcher_instance).to receive(:call) do
          missing_quotes
        end

        subject.missing_weeks = missing_weeks
        subject.fetch_missing_quotes
      end

      its(:missing_quotes) { is_expected.to be(missing_quotes) }
    end

  end

  describe '.fetch_previous_quotes' do
    let(:quote) { class_double('Quote').as_stubbed_const }

    before do
      expect(quote).to receive(:previous).with(forecast_request)
                                         .and_return(cached_quotes)

      subject.fetch_previous_quotes
    end

    its(:cached_quotes) { is_expected.to be(cached_quotes) }
  end

  describe '.find_missing_weeks' do
    before do
      subject.cached_quotes = cached_quotes
      subject.find_missing_weeks
    end

    its(:missing_weeks) { is_expected.to eq(missing_weeks) }
  end

  describe '.combine_cached_and_fetched' do
    before do
      subject.cached_quotes = cached_quotes
      subject.missing_quotes = missing_quotes
    end

    it 'should return array of cached date quotes' do
      result = subject.combine_cached_and_fetched
      expect(result).to eq(combined)
    end
  end
end
