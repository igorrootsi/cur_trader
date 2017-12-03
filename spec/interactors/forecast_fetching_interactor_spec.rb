require 'spec_helper'
require_relative '../../app/interactors/forecast_fetching_interactor'

describe ForecastFetchingInteractor do
  let(:previous_rates_fetcher) do
    instance_double 'PreviousRatesFetchingInteractor'
  end
  let(:previous_rates) { [double] }

  let(:forecast) { [double] }
  let(:forecast_generator) do
    instance_double 'ForecastGenerationInteractor'
  end

  subject do
    ForecastFetchingInteractor.new(previous_rates_fetcher, forecast_generator)
  end

  before do
    expect(previous_rates_fetcher).to receive(:call).and_return(previous_rates)
    expect(forecast_generator).to receive(:call).with(previous_rates)
                                                .and_return(forecast)
  end

  it 'should fetch previous rates' do
    subject.call

    expect(subject.instance_variable_get(:@previous_rates))
      .to eq(previous_rates)
  end

  it 'should fetch forecast based on previous rates' do
    expect(subject.call).to be(forecast)
  end
end
