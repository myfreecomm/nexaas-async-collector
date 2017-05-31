module Nexaas
  module Async
    module Collector
      class ApplicationController < Nexaas::Async::Collector.configuration.parent_controller.constantize
        protect_from_forgery with: :exception
      end
    end
  end
end
