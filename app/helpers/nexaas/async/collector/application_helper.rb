module Nexaas
  module Async
    module Collector
      module ApplicationHelper
        #
        # Helper to enqueue AsyncResourceJob and include the JavaScript code to request the result
        # - unique_id: an ID that is unique for each logged user (maybe user.id, account.id, organization.id, etc)
        # - klass_name: The name of the class responsible for generate the content to be stored in the memory
        # - klass_method: The name of the class method to be called
        # - args: The arguments to be passed in the call of the class method
        #
        # Example:
        # <%= nexaas_async_collect(current_user.id, ReportGenerator, :generate, []) %>
        #
        def nexaas_async_collect(unique_id, klass_name, klass_method, args=[])
          AsyncResourceJob.perform_async(collector_unique_id, unique_id, klass_name, klass_method, args)
          render(partial: 'nexaas/async/collector/async_resource/show')
        end

        private

        def collector_unique_id
          @collector_unique_id ||= SecureRandom.hex(15)
        end

      end
    end
  end
end
