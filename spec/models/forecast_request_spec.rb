describe ForecastRequest do
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :base_currency }
  it { is_expected.to validate_presence_of :target_currency }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :waiting_time }

  context 'Base/Target currency difference' do
    subject do
      build(:forecast_request, base_currency: 'EUR', target_currency: 'EUR')
    end

    before { subject.validate }

    its(:valid?) { is_expected.to be_falsey }

    its('errors.messages') do
      is_expected.to eq target_currency: ['must be different to base currency']
    end
  end
end
