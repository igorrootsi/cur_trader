$ ->
  $('form#new_prediction_request').on 'submit', (event) ->
    $('#prediction').html('')

    save = event.originalEvent.explicitOriginalTarget.value == 'Find and save'
    elements = event.currentTarget.elements

    data = {
      base_currency: elements["prediction_request[base_currency]"].value
      target_currency: elements["prediction_request[target_currency]"].value
      amount: elements["prediction_request[amount]"].value
      waiting_time: elements["prediction_request[waiting_time]"].value
    }

    data.user_id = elements["prediction_request[user_id]"].value if save

    App.prediction.send(data)

    false
