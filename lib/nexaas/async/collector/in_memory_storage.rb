module Nexaas
  module Async
    module Collector
      class InMemoryStorage

        def get(key)
          Sidekiq.redis_pool.with do |connection|
            connection.get(namespaced_key(key))
          end
        end

        def set(key, value, expiration)
          Sidekiq.redis_pool.with do |connection|
            key = namespaced_key(key)
            connection.set(key, value)
            connection.expire(key, expiration)
          end
        end

        private

        def namespaced_key(key)
          "#{redis_namespace}:#{key}"
        end

        def redis_url
          Nexaas::Async::Collector.redis_url
        end

        def redis_namespace
          Nexaas::Async::Collector.redis_namespace
        end

      end
    end
  end
end
