$ ->
  $('form#new_prediction_request').on 'change', (event) ->
    elements = event.currentTarget.elements

    base_currency_field   = elements["prediction_request[base_currency]"]
    target_currency_field = elements["prediction_request[target_currency]"]

    if base_currency_field.value == target_currency_field.value
      target_currency_field.setCustomValidity('Should differ from base currency')
    else
      target_currency_field.setCustomValidity('')

  $('form#new_prediction_request').on 'submit', (event) ->
    elements = event.currentTarget.elements

    base_currency_field   = elements["prediction_request[base_currency]"]
    target_currency_field = elements["prediction_request[target_currency]"]
    amount_field          = elements["prediction_request[amount]"]
    waiting_time_field    = elements["prediction_request[waiting_time]"]

    if event.currentTarget.checkValidity()
      $('#prediction').html('')

      save = event.originalEvent.explicitOriginalTarget.value == 'Find and save'

      data = {
        base_currency:   base_currency_field.value
        target_currency: target_currency_field.value
        amount:          amount_field.value
        waiting_time:    waiting_time_field.value
      }

      data.user_id = elements["prediction_request[user_id]"].value if save

      App.prediction.send(data)
    false
