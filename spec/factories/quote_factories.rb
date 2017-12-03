FactoryBot.define do
  factory :quote do
    provider FFaker::Company.name
    base_currency FFaker::Currency.code
    date Date.today
    rates 'rates'
  end
end
