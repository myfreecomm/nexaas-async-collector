require 'redis-namespace'
require 'sidekiq'
require "nexaas/async/collector/engine"
require "nexaas/async/collector/in_memory_storage"
require "nexaas/async/collector/result"
require "nexaas/async/collector/persist"

module Nexaas
  module Async
    module Collector

      # Redis URL
      mattr_accessor :redis_url
      @@redis_url = ENV.fetch('REDIS_URL') { nil }

      # Namespace used in Redis
      mattr_accessor :redis_namespace
      @@redis_namespace = 'nexaas_async'

      # Method will be called to get the user/account id
      # This ID is used to store and ensure only the user
      # will fetch the processed data.
      mattr_accessor :scope
      @@scope = 'current_user'

      # Parent controller which
      # Nexaas::Async::Collector::AsynResourceController will
      # inherit from
      mattr_accessor :parent_controller
      @@parent_controller = '::ActionController::Base'

      def self.configure
        yield self
      end

    end
  end
end
