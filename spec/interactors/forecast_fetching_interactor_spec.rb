require 'spec_helper'
require_relative '../../app/interactors/forcast_fetching_interactor'

describe ForcastFetchingInteractor do
  let(:previous_rates_fetcher) { instance_double 'PreviousRatesFetchingInteractor' }
  let(:previous_rates) { [double] }

  let(:forcast) { [double] }
  let(:forcast_generator) { instance_double 'ForcastGenerationInteractor'}

  subject {
    ForcastFetchingInteractor.new(previous_rates_fetcher, forcast_generator)
  }

  before do
    expect(previous_rates_fetcher).to receive(:call).and_return(previous_rates)
    expect(forcast_generator).to   receive(:call).with(previous_rates)
                                                    .and_return(forcast)
  end

  it 'should fetch previous rates' do
    subject.call

    expect(subject.instance_variable_get(:@previous_rates)).to eq(previous_rates)
  end

  it 'should fetch forcast based on previous rates' do
    expect(subject.call).to be(forcast)
  end
end