module Providers
  module FixerIo
    class Quote
      attr_accessor :base_currency, :date, :rates, :provider

      def initialize(args)
        @provider      = 'FixerIo'
        @base_currency = args['base']
        @date          = args['date']
        @rates         = args['rates']
      end
    end
  end
end
