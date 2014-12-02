require 'netverify'
require 'pry-byebug'
require 'webmock/rspec'
require 'simplecov'
require_relative 'support/url_helper'

SimpleCov.start

WebMock.disable_net_connect!

Netverify.configure do |config|
  config.token            = 'token-1234'
  config.secret           = 'secret-1234'
  config.company_name     = 'Blueberry'
  config.application_name = 'NetverifyTest'
  config.version          = '1.0.0'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include UrlHelper
end
