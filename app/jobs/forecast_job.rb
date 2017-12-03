class ForecastJob < ApplicationJob
  queue_as :default

  def perform(req)
    dto = ForecastFetchingInteractor.new(req).call

    html = ApplicationController.renderer.render(
      template: 'traders/forecast',
      locals: { dto: dto },
      layout: false
    )

    ActionCable.server.broadcast req.stream_name, html: html

    req.delete unless req.user
  end
end
