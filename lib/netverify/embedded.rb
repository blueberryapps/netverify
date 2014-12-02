require 'securerandom'

module Netverify
  class Embedded
    include Virtus.model

    def response
      raise NotImplementedError
    end

    private

    def endpoint_url
      raise NotImplementedError
    end

    def generate_random_id
      SecureRandom.uuid
    end

    def run_request!
      HTTPClient.
        new(endpoint_url, string_camelizer).
        post_json(attributes)
    end

    def string_camelizer
      StringCamelizer.new
    end
  end
end
