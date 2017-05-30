require 'redis-namespace'
require "nexaas/async/collector/engine"
require "nexaas/async/collector/configuration"
require "nexaas/async/collector/in_memory_storage"
require "nexaas/async/collector/result"

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
