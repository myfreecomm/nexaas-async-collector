module Nexaas
  module Async
    module Collector
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception
      end
    end
  end
end
