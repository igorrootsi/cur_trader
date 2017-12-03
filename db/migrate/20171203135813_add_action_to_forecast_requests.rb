class AddActionToForecastRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :forecast_requests, :after, :string
  end
end
