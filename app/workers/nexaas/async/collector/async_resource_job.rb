module Nexaas
  module Async
    module Collector
      class AsyncResourceJob

        include Sidekiq::Worker
        sidekiq_options queue: :high_fast

        def perform(collector_id, user_id, klass_name, klass_method, args=[])
          content = call_for_method(klass_name, klass_method, args)
          Persist.save(user_id, collector_id, content)
        end

        private

        def call_for_method(klass_name, klass_method, args=[])
          if args.any?
            klass_name.to_s.constantize.send(klass_method, *args)
          else
            klass_name.to_s.constantize.send(klass_method)
          end
        end
      end
    end
  end
end
