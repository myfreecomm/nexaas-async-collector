module Nexaas
  module Async
    module Collector
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception

        private

        # nac = short of nexaas-async-collector
        def current_nac_resource
          current_user || raise('nexaas-async-collector: You have to declare a current_user method or override #current_nac_resource in your ApplicationController.')
        end
      end
    end
  end
end
