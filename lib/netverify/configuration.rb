module Netverify
  class Configuration
    include Virtus.model

    ConfigurationMissing = Class.new(StandardError)

    attribute :token, String
    attribute :secret, String
    attribute :company_name, String
    attribute :application_name, String
    attribute :version, String

    def validate!
      missing = attributes.keys.select { |key| public_send(key).nil? }
      raise ConfigurationMissing, missing.join(', ') unless missing.empty?
    end
  end
end
