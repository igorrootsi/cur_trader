require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CurTrader
  class Application < Rails::Application
    config.load_defaults 5.1
    config.action_view.field_error_proc = Proc.new do |html_tag, _instance|
      html_tag.html_safe
    end

    config.active_job.queue_adapter = :sidekiq
  end
end

Time::DATE_FORMATS[:year_month_day] = '%Y-%B-%D'
