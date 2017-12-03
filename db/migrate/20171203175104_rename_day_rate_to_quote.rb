class RenameDayRateToQuote < ActiveRecord::Migration[5.1]
  def change
    rename_table :day_rates, :quotes
  end
end
