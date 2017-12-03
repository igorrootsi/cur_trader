class ForecastChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_name
  end

  def receive(data)
    ForecastJob.perform_now get_forecast_request(data)
  end

  def stream_name
    "forecast_channel_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_forecast_request(data)
    merged = data.merge stream_name: stream_name

    if data['after'] == 'update'
      ForecastRequest.update(data['id'], merged)
    else
      merged.delete('id')
      ForecastRequest.create(merged)
    end
  end
end
