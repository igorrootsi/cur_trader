class AddStreamNameToPredictionRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :prediction_requests, :stream_name, :string
  end
end
