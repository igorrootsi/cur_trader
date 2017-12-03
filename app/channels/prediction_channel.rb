class PredictionChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_name
  end

  def receive(data)
    prediction_request = PredictionRequest.new(data)
    prediction_request.stream_name = stream_name
    prediction_request.save

    PredictionJob.perform_now prediction_request
  end

  def stream_name
    "prediction_channel_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
