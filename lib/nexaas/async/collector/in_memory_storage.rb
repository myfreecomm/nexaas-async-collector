module Nexaas
  module Async
    module Collector
      class InMemoryStorage

        attr_reader :connection, :namespace

        def initialize
          @connection ||= Redis.new(url: redis_url)
          @namespace ||= Redis::Namespace.new(redis_namespace, redis: connection) if redis_namespace
        end

        def get(key)
          storage.get(key)
        end

        def set(key, value, expiration=nil)
          storage.set(key, value)
          storage.expire(key, expiration) if expiration
        end

        private

        def storage
          @namespace || @connection
        end

        def redis_url
          Nexaas::Async::Collector.configuration.redis_url
        end

        def redis_namespace
          Nexaas::Async::Collector.configuration.redis_namespace
        end

      end
    end
  end
end
