class Rates < ActiveRecord::Migration[5.1]
  def change
    create_table :day_rates do |t|
      t.string   :provider
      t.string   :base_currency, limit: 3
      t.datetime :date
      t.jsonb    :rates
    end
  end
end
