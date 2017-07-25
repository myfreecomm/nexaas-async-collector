require_dependency "nexaas/async/collector/application_controller"

module Nexaas
  module Async
    module Collector
      class AsyncResourceController < ApplicationController
        respond_to :all

        def show
          @result = Result.new(collector_scope.id, params[:id])
          @unique_id = params[:unique_id]
          if request.format.symbol == :js
            render :show
          end
        end

        private

        def collector_scope
          send(Nexaas::Async::Collector.scope)
        end
      end
    end
  end
end
