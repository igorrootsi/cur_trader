class PredictionRequest < ActiveRecord::Migration[5.1]
  def change
    create_table :prediction_requests do |t|
      t.belongs_to :user

      t.string :base_currency, limit: 3
      t.string :target_currency, limit: 3
      t.integer :amount
      t.integer :waiting_time
    end
  end
end
