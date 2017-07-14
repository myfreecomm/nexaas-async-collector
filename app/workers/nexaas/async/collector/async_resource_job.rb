module Nexaas
  module Async
    module Collector
      class AsyncResourceJob

        include Sidekiq::Worker
        sidekiq_options queue: Nexaas::Async::Collector.queue_name

        def perform(opts={})
          initialize_options(opts)
          start_time = Time.current.to_i
          instrument_start(start_time)
          Persist.save(@scope_id, @collect_id, generate_content)
          instrument_finish(start_time)
        end

        private

        def initialize_options(opts)
          opts.each do |k, v|
            instance_variable_set("@#{k}", v)
          end
        end

        def generate_content
          if @args && @args.any?
            @class_name.to_s.constantize.send(@class_method, *@args)
          else
            @class_name.to_s.constantize.send(@class_method)
          end
        end

        def instrument_start(start_time)
          ActiveSupport::Notifications.instrument("#{instrumentation_context}.start", {
            collect_id: @collect_id, scope_id: @scope_id,
            class_name: @class_name, class_method: @class_method,
            start: start_time
          })
        end

        def instrument_finish(start_time)
          finish = Time.current.to_i
          duration = (finish - start_time)
          ActiveSupport::Notifications.instrument("#{instrumentation_context}.finish", {
            collect_id: @collect_id, scope_id: @scope_id,
            class_name: @class_name, class_method: @class_method,
            finish: finish, duration: duration
          })
        end

        def instrumentation_context
          @instrumentation_context || 'nexaas-async-collector'
        end
      end
    end
  end
end
