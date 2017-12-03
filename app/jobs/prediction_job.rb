class PredictionJob < ApplicationJob
  queue_as :default

  def perform(req)
    dto = PredictionFetchingInteractor.new(req).call

    html = ApplicationController.renderer.render(
      template: 'traders/prediction',
      locals: { dto: dto },
      layout: false
    )

    ActionCable.server.broadcast req.stream_name, html: html

    req.delete unless req.user
  end
end
