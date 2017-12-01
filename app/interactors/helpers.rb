def coerce_day_to_week(day = Time.now)
  day.to_date.beginning_of_week
end
