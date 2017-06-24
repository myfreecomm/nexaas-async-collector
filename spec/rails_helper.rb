# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb", __FILE__)

Dir[File.join File.dirname(__FILE__), 'support', '**', '*.rb'].each { |f| require f }

require 'rspec/rails'
require 'fakeredis'
require 'fakeredis/rspec'
require 'byebug'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'nexaas/async/collector'
