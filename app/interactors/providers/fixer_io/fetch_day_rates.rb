module Providers
  module FixerIo
    class FetchDayRates
      def initialize(req)
        @req = req
      end

      def call(dates)
        missing = dates.map do |date|
          url = "https://api.fixer.io/#{date}"
          params = { params: { base: @req.base_currency }}

          response = RestClient.get url, params

          Providers::FixerIo::DayRate.new(JSON.parse(response))
        end

        ::DayRate.create(JSON.parse(missing.to_json))
      end
    end
  end
end
