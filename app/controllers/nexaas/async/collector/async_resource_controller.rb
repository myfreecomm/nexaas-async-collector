require_dependency "nexaas/async/collector/application_controller"

module Nexaas
  module Async
    module Collector
      class AsyncResourceController < ApplicationController

        def show
          @result = Result.new(collector_scope.id, params[:id])
          @unique_id = params[:unique_id]
          respond_to do |format|
            render_for_request(format)
          end
        end

        private

        def render_for_request(format)
          format.js { render :show }
          format.all do
            send_data(@result.content, {
              filename: "#{@result.filename}.#{@result.extension}", type: @result.content_type,
              disposition: 'attachment'
            })
          end
        end

        def collector_scope
          send(Nexaas::Async::Collector.scope)
        end
      end
    end
  end
end
