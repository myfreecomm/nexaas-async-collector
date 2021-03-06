require 'sidekiq'
require "nexaas/async/collector/engine"
require "nexaas/async/collector/storage"
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

      # Name of the sidekiq queue to be used
      mattr_accessor :queue_name
      @@queue_name = :high_fast

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

      # Sets expiration (in seconds) for content in database
      mattr_accessor :expiration
      @@expiration = 600 # 10 minutes

      def self.configure
        yield self
      end

    end
  end
end
