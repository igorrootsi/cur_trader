require 'spec_helper'
require_relative '../../app/interactors/prediction_fetching_interactor'

describe PredictionFetchingInteractor do
  let(:previous_rates_fetcher) { instance_double 'PreviousRatesFetchingInteractor' }
  let(:previous_rates) { [double] }

  let(:prediction) { [double] }
  let(:prediction_generator) { instance_double 'PredictionGenerationInteractor'}

  subject {
    PredictionFetchingInteractor.new(previous_rates_fetcher, prediction_generator)
  }

  before do
    expect(previous_rates_fetcher).to receive(:call).and_return(previous_rates)
    expect(prediction_generator).to   receive(:call).with(previous_rates)
                                                    .and_return(prediction)
  end

  it 'should fetch previous rates' do
    subject.call

    expect(subject.instance_variable_get(:@previous_rates)).to eq(previous_rates)
  end

  it 'should fetch prediction based on previous rates' do
    expect(subject.call).to be(prediction)
  end
end