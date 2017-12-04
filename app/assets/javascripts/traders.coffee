$ ->
  $('form#new_forecast_request, form.edit_forecast_request').on 'change', (event) ->
    elements = event.currentTarget.elements

    base_currency_field   = elements["forecast_request[base_currency]"]
    target_currency_field = elements["forecast_request[target_currency]"]

    if base_currency_field.value == target_currency_field.value
      target_currency_field.setCustomValidity('Should differ from base currency')
    else
      target_currency_field.setCustomValidity('')

  $('form#new_forecast_request, form.edit_forecast_request').on 'submit', (event) ->
    event.preventDefault();
    elements = event.currentTarget.elements

    base_currency_field   = elements["forecast_request[base_currency]"]
    target_currency_field = elements["forecast_request[target_currency]"]
    amount_field          = elements["forecast_request[amount]"]
    waiting_time_field    = elements["forecast_request[waiting_time]"]
    user_id               = elements["forecast_request[user_id]"].value
    id                    = elements["forecast_request[id]"] && elements["forecast_request[id]"].value

    if event.currentTarget.checkValidity()
      $('#forecast').html('')

      submit_buttons = $("input[type=submit]:focus")
      after = submit_buttons.length && submit_buttons[0].dataset.after || 'delete'

      data = {
        base_currency:   base_currency_field.value
        target_currency: target_currency_field.value
        amount:          amount_field.value
        waiting_time:    waiting_time_field.value
        user_id:         user_id
        after:           after
      }

      data.id = id if id

      App.forecast.send(data)
    false
