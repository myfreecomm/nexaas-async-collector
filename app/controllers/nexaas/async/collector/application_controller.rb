module Nexaas
  module Async
    module Collector
      class ApplicationController < Nexaas::Async::Collector.parent_controller.constantize
        protect_from_forgery with: :exception
      end
    end
  end
end
