module Nexaas
  module Async
    module Collector
      class AsyncResourceJob

        include Sidekiq::Worker
        sidekiq_options queue: :high_fast

        def perform(collector_id, unique_id, klass_name, klass_method, args=[])
          content = klass_name.send(klass_method, unique_id, *args)
          Persist.save(unique_id, collector_id, content)
        end
      end
    end
  end
end
