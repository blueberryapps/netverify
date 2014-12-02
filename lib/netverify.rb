require 'virtus'

require_relative 'netverify/configuration'
require_relative 'netverify/http_client'
require_relative 'netverify/string_camelizer'
require_relative 'netverify/embedded'
require_relative 'netverify/response'
require_relative 'netverify/iframe'
require_relative 'netverify/multi_document_iframe'

module Netverify
  ConfigurationMissing = Class.new(StandardError)

  module_function

  def configure
    @config = Configuration.new
    yield @config
    @config.validate!
  end

  def config
    @config
  end
end
