params = {
  channel: "PredictionChannel",
  id: Math.random().toString().split('.')[1]
}

App.prediction = App.cable.subscriptions.create params,
  received: (data) -> $('#prediction').html(data['html'])
