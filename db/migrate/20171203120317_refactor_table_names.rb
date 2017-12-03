class RefactorTableNames < ActiveRecord::Migration[5.1]
  def change
    rename_index :prediction_requests,
                 'index_prediction_requests_on_user_id',
                 'index_forecast_requests_on_user_id'
    rename_table :prediction_requests, :forecast_requests
  end
end
