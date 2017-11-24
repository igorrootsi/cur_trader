class StockRequest
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :base_currency, :target_currency, :amount, :waiting_time
  validates :base_currency, :target_currency, :amount, :waiting_time,
    presence: true

  validate :base_and_target_currencies_are_same

  def initialize(args)
    @base_currency = args['base_currency']
    @target_currency = args['target_currency']
    @amount = args['amount']
    @waiting_time = args['waiting_time']
  end

  def base_and_target_currencies_are_same
    if self.base_currency == self.target_currency
      errors.add(:target_currency, 'must be different to base currency')
    end
  end

  def persisted?
    false
  end
end