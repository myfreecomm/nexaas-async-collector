module Nexaas
  module Async
    module Collector
      class Persist
        class << self
          def save(opts={})
            opts = opts.with_indifferent_access
            content = content_in_json(opts)
            storage.set(opts[:collect_id], content)
          end

          private

          def content_in_json(opts)
            {
              'scope_id' => opts[:scope_id],
              'content' => Base64.encode64(opts[:content].to_s),
              'file' => opts[:file]
            }.to_json
          end

          def storage
            InMemoryStorage.new
          end
        end
      end
    end
  end
end
