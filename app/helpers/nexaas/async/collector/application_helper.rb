module Nexaas
  module Async
    module Collector
      module ApplicationHelper
        #
        # Helper to enqueue AsyncResourceJob and include the JavaScript code to request the result
        # - user_id: an ID that is unique for each logged user (maybe user.id, account.id, organization.id, etc)
        # - klass_name: The name of the class responsible for generate the content to be stored in the memory
        # - klass_method: The name of the class method to be called
        # - args: The arguments to be passed in the call of the class method
        #
        # Example:
        # <%= nexaas_async_collect(current_user.id, ReportGenerator, :generate, []) %>
        #
        def nexaas_async_collect(user_id, klass_name, klass_method, args=[])
          AsyncResourceJob.perform_async(collector_user_id, user_id, klass_name, klass_method, args)
          render(partial: 'nexaas/async/collector/async_resource/show')
        end

        # Rails 4.x does not add this helper automatically as Rails 5.X and 3.X does. So we had to created it to keep
        # the same interface.
        def nexaas_async_collector
          @@nexaas_async_collector ||= Nexaas::Async::Collector::Engine.routes.url_helpers
        end

        private

        def collector_user_id
          @collector_user_id ||= SecureRandom.hex(15)
        end

      end
    end
  end
end
