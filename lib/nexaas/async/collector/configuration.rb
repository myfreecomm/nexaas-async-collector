module Nexaas
  module Async
    module Collector
      class Configuration
        attr_accessor :redis_url, :redis_namespace

        def initialize
          @redis_url = ENV.fetch('REDIS_URL') { nil }
          @redis_namespace = 'nexaas_async'
        end
      end
    end
  end
end
