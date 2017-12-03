params = {
  channel: "ForecastChannel",
  id: Math.random().toString().split('.')[1]
}

App.forecast = App.cable.subscriptions.create params,
  received: (data) -> $('#forecast').html(data['html'])
