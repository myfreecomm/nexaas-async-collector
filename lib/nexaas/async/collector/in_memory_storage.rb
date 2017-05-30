module Nexaas
  module Async
    module Collector
      class InMemoryStorage

        attr_reader :connection, :namespace

        def initialize(url, namespace=nil)
          @connection ||= Redis.new(url: url)
          @namespace ||= Redis::Namespace.new(namespace, redis: connection) if namespace
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

      end
    end
  end
end
