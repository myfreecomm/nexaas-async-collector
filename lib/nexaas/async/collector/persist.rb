module Nexaas
  module Async
    module Collector
      class Persist

        attr_reader :opts, :storage

        def initialize(opts={})
          @opts = opts.with_indifferent_access
          @storage = Storage.new
        end

        def self.save(opts={})
          new(opts).save
        end

        def save
          content = content_in_json(opts)
          storage.set(opts[:collect_id], content, expiration)
        end

        private

        def content_in_json(opts)
          {
            'scope_id' => opts[:scope_id],
            'content' => (opts[:content] ? Base64.encode64(opts[:content].to_s) : nil),
            'file' => opts[:file]
          }.to_json
        end

        def expiration
          opts[:expiration] || Nexaas::Async::Collector.expiration
        end
      end
    end
  end
end
