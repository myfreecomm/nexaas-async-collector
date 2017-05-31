module Nexaas
  module Async
    module Collector
      class AsyncResourceController < ApplicationController
        def show
          @result = Result.new(current_nac_resource.id, params[:id])
          respond_to { |f| f.js }
        end
      end
    end
  end
end
