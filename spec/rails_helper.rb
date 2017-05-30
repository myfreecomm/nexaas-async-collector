ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'
require 'fakeredis'
require 'fakeredis/rspec'
require 'byebug'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nexaas/async/collector'

require File.expand_path("../dummy/config/environment.rb", __FILE__)
