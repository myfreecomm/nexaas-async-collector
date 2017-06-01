module Nexaas
  module Async
    module Collector
      class Persist
        class << self
          def save(user_id, key, value)
            storage.set(key, content(user_id, value))
          end

          def content(user_id, value)
            {
              'user_id' => user_id,
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
