require_dependency "nexaas/async/collector/application_controller"

module Nexaas
  module Async
    module Collector
      class AsyncResourceController < ApplicationController
        def show
          @result = Result.new(collector_scope.id, params[:id])
          @unique_id = params[:unique_id]
          respond_to { |f| f.js }
        end

        private

        def nexaas_async_collector_scope
          Nexaas::Async::Collector.scope
        end

        def collector_scope
          send(nexaas_async_collector_scope)
        end
      end
    end
  end
end
