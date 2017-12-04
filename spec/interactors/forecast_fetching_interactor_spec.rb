require 'spec_helper'
require_relative '../../app/interactors/forecast_fetching_interactor'

describe ForecastFetchingInteractor, '#new' do
  let(:request) { double 'ForecastRequest' }

  subject { ForecastFetchingInteractor.new(request) }

  its(:forecast_request) { is_expected.to be request }
  its(:dto) { is_expected.to be_instance_of ForecastResponseDTO }
end

describe ForecastFetchingInteractor, '.call' do
  subject { ForecastFetchingInteractor.new(double 'ForecastRequest') }

  before do
    expect(subject).to receive(:fetch_previous_quotes)
    expect(subject).to receive(:generate_forecast)
    expect(subject).to receive(:generate_ranks)
    expect(subject).to receive(:generate_base)
  end

  it 'should return ForecastResponseDTO instance' do
    expect(subject.call).to be_instance_of ForecastResponseDTO
  end
end

describe ForecastFetchingInteractor, '.fetch_previous_quotes' do
  fetcher_klass = 'HistoricalQuotesFetchingInteractor'

  subject { ForecastFetchingInteractor.new(request) }

  let(:request)           { double 'ForecastRequest' }
  let(:historical_quotes) { [double('Quote')] }

  let(:fetcher_class) { class_double(fetcher_klass).as_stubbed_const }
  let(:fetcher)       { instance_double(fetcher_klass) }

  before do
    expect(fetcher_class).to receive(:new).with(request).and_return(fetcher)
    expect(fetcher).to receive(:call).and_return(historical_quotes)

    subject.fetch_previous_quotes
  end

  its('dto.previous_quotes') { is_expected.to be historical_quotes }
end

describe ForecastFetchingInteractor, '.generate_forecast' do
  generator_klass = 'ForecastGenerator'

  subject { ForecastFetchingInteractor.new(request) }

  let(:request) { double 'ForecastRequest' }
  let(:quotes)  { [double('Quote')] }

  let(:generator_class) { class_double(generator_klass).as_stubbed_const }
  let(:generator)       { instance_double(generator_klass) }

  before do
    expect(generator_class).to receive(:new).with(request, subject.dto) do
      generator
    end
    expect(generator).to receive(:call).and_return(quotes)

    subject.generate_forecast
  end

  its('dto.quotes') { is_expected.to be quotes }
end

describe ForecastFetchingInteractor do
  subject { ForecastFetchingInteractor.new(double('ForecastRequest')) }

  describe '.generate_ranks' do
    before do
      subject.dto.quotes = [1, 4, 2, 6, 7]
      subject.generate_ranks
    end

    its('dto.ranks') { is_expected.to eq [7, 6, 4] }
  end

  describe '.generate_base' do
    before do
      subject.dto.quotes = [double('Quote', rate: 5)]
      subject.generate_base
    end

    its('dto.base') { is_expected.to eq 5 }
  end
end


