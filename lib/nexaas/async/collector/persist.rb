module Nexaas
  module Async
    module Collector
      class Persist
        class << self
          def save(unique_id, key, value)
            storage.set(key, content(unique_id, value))
          end

          def content(unique_id, value)
            {
              'unique_id' => unique_id,
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
