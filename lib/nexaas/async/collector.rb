require "nexaas/async/collector/engine"
require "nexaas/async/collector/configuration"

module Nexaas
  module Async
    module Collector
      class << self
        def configure
          yield(configuration)
        end

        def configuration
          @configuration ||= Configuration.new
        end
      end
    end
  end
end
