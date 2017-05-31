module Nexaas
  module Async
    module Collector
      class Configuration
        attr_accessor :redis_url, :redis_namespace, :scope, :parent_controller

        def initialize
          @redis_url = ENV.fetch('REDIS_URL') { nil }
          @redis_namespace = 'nexaas_async'
          @scope = :current_user
          @parent_controller = '::ActionController::Base'
        end
      end
    end
  end
end
