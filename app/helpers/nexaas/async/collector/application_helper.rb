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
        # - instrumentation_context: Custom context for instrumentatio with ActiveSupport::Notifications
        # - file: Argument to pass file informations. This will be used to generated file for the user
        #   - conten_type: Content type of the file
        #   - name: Basename of the file to be generated
        #
        # Example:
        # <%= nexaas_async_collect({
        #   scope_id: current_user.id, class_name: ReportGenerator,
        #   class_method: :generate, args: [],
        #   file: { content_type: 'application/json', name: 'data' }
        # }) %>
        #
        def nexaas_async_collect(opts={})
          async_resource = Nexaas::Async::Collector::AsyncResource.new(opts)
          async_resource.save!
          render(partial: 'nexaas/async/collector/async_resource/show', locals: {
            unique_id: SecureRandom.hex,
            collect_id: async_resource.collect_id
          })
        end

        # Rails 4.x does not add this helper automatically as Rails 5.X and 3.X does. So we had to created it to keep
        # the same interface.
        def nexaas_async_collector
          @@nexaas_async_collector ||= Nexaas::Async::Collector::Engine.routes.url_helpers
        end

      end
    end
  end
end
