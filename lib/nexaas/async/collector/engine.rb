module Nexaas
  module Async
    module Collector
      class Engine < ::Rails::Engine
        isolate_namespace Nexaas::Async::Collector

        config.to_prepare do
          Nexaas::Async::Collector.parent_controller.constantize.helper(Nexaas::Async::Collector::ApplicationHelper)
        end

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
