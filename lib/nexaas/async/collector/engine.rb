module Nexaas
  module Async
    module Collector
      class Engine < ::Rails::Engine
        isolate_namespace Nexaas::Async::Collector

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
