module Nexaas
  module Async
    module Collector
      class Persist
        class << self
          def save(scope_id, key, value)
            storage.set(key, content(scope_id, value))
          end

          def content(scope_id, value)
            {
              'scope_id' => scope_id,
              'content' => value
            }.to_json
          end

          private

          def storage
            InMemoryStorage.new
          end
        end
      end
    end
  end
end
