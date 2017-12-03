require 'rails_helper'

describe DayRate do
  it { is_expected.to validate_presence_of :provider }
  it { is_expected.to validate_presence_of :base_currency }
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :rates }
end

describe DayRate, '.previous' do
  let(:period) { 5 }
  let(:base_currency) { 'EUR' }
  let(:forcast_request) do
    build :forcast_request, base_currency: base_currency
  end
  let!(:day_rate) {
    create :day_rate, date: Date.today - period.days, base_currency: base_currency
  }

  context 'Cached rates are present at given period' do
    it 'should find all cached rates' do
      result = DayRate.previous(period, forcast_request)

      expect(result).to eq [day_rate]
    end
  end

  context 'Cached rates are missing at given period' do
    it 'should not return old rates' do
      result = DayRate.previous(period - 1, forcast_request)

      expect(result).to eq []
    end
  end

  context 'Cached rates are missing for given base currency' do
    it 'should not return rates for wrong base_currency' do
      forcast_request.base_currency = 'WRONG'

      result = DayRate.previous(period, forcast_request)

      expect(result).to eq []
    end
  end
end