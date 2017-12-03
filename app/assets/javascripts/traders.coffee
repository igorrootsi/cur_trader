$ ->
  $('form#new_forecast_request').on 'change', (event) ->
    elements = event.currentTarget.elements

    base_currency_field   = elements["forecast_request[base_currency]"]
    target_currency_field = elements["forecast_request[target_currency]"]

    if base_currency_field.value == target_currency_field.value
      target_currency_field.setCustomValidity('Should differ from base currency')
    else
      target_currency_field.setCustomValidity('')

  $('form#new_forecast_request').on 'submit', (event) ->
    elements = event.currentTarget.elements

    base_currency_field   = elements["forecast_request[base_currency]"]
    target_currency_field = elements["forecast_request[target_currency]"]
    amount_field          = elements["forecast_request[amount]"]
    waiting_time_field    = elements["forecast_request[waiting_time]"]

    if event.currentTarget.checkValidity()
      $('#forecast').html('')

      save = event.originalEvent.explicitOriginalTarget.value == 'Find and save'

      data = {
        base_currency:   base_currency_field.value
        target_currency: target_currency_field.value
        amount:          amount_field.value
        waiting_time:    waiting_time_field.value
      }

      data.user_id = elements["forecast_request[user_id]"].value if save

      App.forecast.send(data)
    false
