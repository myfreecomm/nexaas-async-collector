module Nexaas
  module Async
    module Collector
      class AsyncResourceJob

        include Sidekiq::Worker
        sidekiq_options queue: Nexaas::Async::Collector.queue_name

        def perform(collect_id, user_id, klass_name, klass_method, args=[])
          instrument_start(collect_id, user_id, klass_name, klass_method)
          content = call_for_method(klass_name, klass_method, args)
          Persist.save(user_id, collect_id, content)
          instrument_finish(collect_id, user_id, klass_name, klass_method)
        end

        private

        def call_for_method(klass_name, klass_method, args=[])
          if args.any?
            klass_name.to_s.constantize.send(klass_method, *args)
          else
            klass_name.to_s.constantize.send(klass_method)
          end
        end

        def instrument_start(collect_id, user_id, klass_name, klass_method)
          @start = Time.current.to_i
          ActiveSupport::Notifications.instrument("#{instrumentation_context}.start", {
            collect_id: collect_id, user_id: user_id,
            class_name: klass_name, class_method: klass_method,
            start: @start
          })
        end

        def instrument_finish(collect_id, user_id, klass_name, klass_method)
          finish = Time.current.to_i
          duration = (finish - @start)
          ActiveSupport::Notifications.instrument("#{instrumentation_context}.finish", {
            collect_id: collect_id, user_id: user_id,
            class_name: klass_name, class_method: klass_method,
            finish: finish, duration: duration
          })
        end

        def instrumentation_context
          Nexaas::Async::Collector.instrumentation_context
        end
      end
    end
  end
end
