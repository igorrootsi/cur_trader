class ForecastChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_name
  end

  def receive(data)
    forecast_request = ForecastRequest.new(data)
    forecast_request.stream_name = stream_name
    forecast_request.save

    ForecastJob.perform_now forecast_request
  end

  def stream_name
    "forecast_channel_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
