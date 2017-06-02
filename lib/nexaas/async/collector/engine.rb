module Nexaas
  module Async
    module Collector
      class Engine < ::Rails::Engine
        initializer 'Nexaas::Async::Collector precompile hook', group: :all do |app|
          app.config.assets.precompile += %w(
            nexaas/async/collector/spin.svg
          )
        end

        config.generators do |g|
          g.test_framework :rspec
        end
      end
    end
  end
end
