require 'active_support/core_ext/numeric/time'
require 'spec_helper'
require_relative '../../app/interactors/previous_rates_fetching_interactor'

describe PreviousRatesFetchingInteractor do
  let(:prediction_request) { double :PredictionRequest }

  subject { PreviousRatesFetchingInteractor.new(1, prediction_request) }

  let(:cached_rates)  { [double(:DayRate1, date: Date.today)] }
  let(:missing_rates) { [double(:DayRate2, date: Date.today - 1.day)] }
  let(:missing_days)  { [Date.today - 1.days] }

  let(:combined) { [missing_rates.first, cached_rates.first] }

  describe '.call' do
    before do
      is_expected.to receive(:fetch_previous_rates)
      is_expected.to receive(:find_missing_days)
      is_expected.to receive(:combine_cached_and_fetched) { combined }
    end

    context 'rates for all days are cached' do
      before { subject.missing_days = [] }
      it 'it should return array of previous rates' do
        is_expected.to_not receive(:fetch_missing_rates)

        expect(subject.call).to be(combined)
      end
    end

    context 'some rates are not cached' do
      before { subject.missing_days = missing_days }
      it 'it should return array of previous rates' do
        is_expected.to receive(:fetch_missing_rates)

        expect(subject.call).to be(combined)
      end
    end
  end

  describe '.fetch_missing_rates' do
    let(:fetcher_instance) { double('FetcherInstance', call: []) }
    let(:fetcher) do
      class_double(
        '::Providers::FixerIo::FetchDayRates',
        new: fetcher_instance
      ).as_stubbed_const
    end

    before do
      expect(fetcher).to receive(:new)
      expect(fetcher_instance).to receive(:call).with(missing_days) { missing_rates }

      subject.missing_days = missing_days
      subject.fetch_missing_rates
    end

    its(:missing_rates) { is_expected.to be(missing_rates) }
  end

  describe '.fetch_previous_rates' do
    let(:day_rate) { class_double('DayRate').as_stubbed_const }

    before do
      expect(day_rate).to receive(:previous).with(1, prediction_request).and_return(cached_rates)

      subject.fetch_previous_rates
    end

    its(:cached_rates) { is_expected.to be(cached_rates) }
  end

  describe '.find_missing_days' do
    before do
      subject.cached_rates = cached_rates
      subject.find_missing_days
    end

    its(:missing_days) { is_expected.to eq(missing_days) }
  end

  describe '.combine_cached_and_fetched' do
    before do
      subject.cached_rates = cached_rates
      subject.missing_rates = missing_rates
    end

    it 'should return array of cached date rates' do
      result = subject.combine_cached_and_fetched
      expect(result).to eq(combined)
    end
  end
end