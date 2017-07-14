module Nexaas
  module Async
    module Collector
      module ApplicationHelper
        #
        # Helper to enqueue AsyncResourceJob and include the JavaScript code to request the result
        # - scope_id: an ID that is unique (maybe user.id, account.id, organization.id, etc)
        # - klass_name: The name of the class responsible for generate the content to be stored in the memory
        # - klass_method: The name of the class method to be called
        # - args: The arguments to be passed in the call of the class method
        #
        # Example:
        # <%= nexaas_async_collect(current_user.id, ReportGenerator, :generate, []) %>
        #
        def nexaas_async_collect(opts={})
          validate_options(opts)
          opts.merge!({ collect_id: collect_id })
          AsyncResourceJob.perform_async(opts)
          render(partial: 'nexaas/async/collector/async_resource/show')
        end

        # Rails 4.x does not add this helper automatically as Rails 5.X and 3.X does. So we had to created it to keep
        # the same interface.
        def nexaas_async_collector
          @@nexaas_async_collector ||= Nexaas::Async::Collector::Engine.routes.url_helpers
        end

        private

        def validate_options(opts={})
          missing_keys = required_collect_opts - opts.keys.map(&:to_s)
          if missing_keys.any?
            raise "Nexaas::Async::Collector: Required parameter missing: #{missing_keys.join(', ')}"
          end
        end

        def collect_id
          @collect_id ||= SecureRandom.hex(15)
        end

        def required_collect_opts
          ['scope_id', 'class_name', 'class_method']
        end

      end
    end
  end
end
