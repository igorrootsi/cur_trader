FactoryBot.define do
  factory :prediction_request do
    user
    base_currency FFaker::Currency.code
    target_currency FFaker::Currency.code
    amount 100
    waiting_time 10
  end
end