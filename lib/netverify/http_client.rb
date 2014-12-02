require 'net/http'
require 'json'
require 'active_support/core_ext'

module Netverify
  class HTTPClient
    ResponseError = Class.new(StandardError)

    def initialize(url)
      @url = url
    end

    def post_json(data)
      request.body = camelized_json(data)

      result = run_request!

      underscored_json(result.body)
    end

    private

    def camelized_json(data)
      hash = data.
        delete_if { |_, value| value.nil? }.
        transform_keys(&method(:camelize_key))

      JSON.dump(hash)
    end

    def underscored_json(json)
      JSON.parse(json).transform_keys!(&:underscore)
    end

    def camelize_key(key)
      {
        customer_id: 'customerID'
      }[key] || key.to_s.camelize(:lower)
    end

    def config
      Netverify.config
    end

    def request
      @request ||= Net::HTTP::Post.new(uri).tap do |request|
        request['Accept']       = 'application/json'
        request['Content-Type'] = 'application/json'
        request['User-Agent']   = user_agent
        request.basic_auth(config.token, config.secret)
      end
    end

    def run_request!
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: use_ssl?) do |http|
        http.request(request)
      end

      raise ResponseError, response.body unless response.is_a? Net::HTTPOK

      response
    end

    def uri
      @uri ||= URI(@url)
    end

    def use_ssl?
      uri.scheme == 'https'
    end

    def user_agent
      "#{config.company_name} #{config.application_name}/#{config.version}"
    end
  end
end
