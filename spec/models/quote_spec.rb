require 'rails_helper'

describe Quote do
  it { is_expected.to validate_presence_of :provider }
  it { is_expected.to validate_presence_of :base_currency }
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :rates }
end

describe Quote, '.previous' do
  let(:base_currency) { 'EUR' }
  let(:forecast_request) do
    build :forecast_request, base_currency: base_currency, waiting_time: 5
  end
  let!(:quote) do
    create :quote, date: Date.today - period.days, base_currency: base_currency
  end
  subject { Quote.previous(forecast_request) }

  context 'Cached rates are present at given period' do
    it 'should find all cached rates' do
      expect(subject).to eq [quote]
    end
  end

  context 'Cached rates are missing at given period' do
    it 'should not return old rates' do
      result = Quote.previous(forecast_request)

      expect(result).to eq []
    end
  end

  context 'Cached rates are missing for given base currency' do
    it 'should not return rates for wrong base_currency' do
      forecast_request.base_currency = 'WRONG'

      result = Quote.previous(forecast_request)

      expect(result).to eq []
    end
  end
end