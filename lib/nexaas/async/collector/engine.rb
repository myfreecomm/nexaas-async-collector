module Nexaas
  module Async
    module Collector
      class Engine < ::Rails::Engine
        isolate_namespace Nexaas::Async
      end
    end
  end
end
