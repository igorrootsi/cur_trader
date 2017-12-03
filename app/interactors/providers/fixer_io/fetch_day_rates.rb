module Providers
  module FixerIo
    class FetchDayRates
      def initialize(req, missing_weeks)
        @req = req
        @missing_weeks = missing_weeks
        @received_data = []
      end

      def call
        iterate

        ::Quote.create(JSON.parse(@received_data.to_json))
      end

      def iterate
        while @missing_weeks.any?
          week = @missing_weeks.shift

          begin
            fetch week
          rescue RestClient::TooManyRequests
            @missing_weeks.unshift week
            sleep 5.seconds

            iterate
          end
        end
      end

      def fetch(week)
        url = "https://api.fixer.io/#{week}"
        params = { params: { base: @req.base_currency }}
        response = RestClient.get url, params
        obj = Providers::FixerIo::Quote.new(JSON.parse(response))

        progress = @received_data.length * 100 / @req.waiting_time
        send(progress)

        @received_data.push obj
      end

      # @param [Integer] progress
      def send(progress)
        html = ApplicationController.renderer.render(
          template: 'traders/progress',
          locals: { progress: progress },
          layout: false
        )

        ActionCable.server.broadcast @req.stream_name, html: html
      end
    end
  end
end
