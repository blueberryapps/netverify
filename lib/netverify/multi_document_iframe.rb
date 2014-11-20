require_relative 'multi_document_response'

module Netverify
  class MultiDocumentIframe < Embedded

    ##############################
    # REQUIRED
    ##############################

    # Expected document type
    # You receive possible parameters by calling the RESTful API
    # supportedDocumentTypes
    attribute :document_type, String

    # Your reference for each scan must not contain sensitive data like email
    # address or account login
    attribute :merchant_scan_reference, String, default: :generate_random_id

    # Identification of the customer should not contain sensitive data like
    # email address or account login
    attribute :customer_id, String

    # Redirect URL in case of success. This setting overrides your Jumio
    # merchant settings. We strongly recommend providing an HTTPS URL using the
    # TLS protocol (ports are not allowed).
    #
    # *Mandatory if not specified in your Jumio merchant settings.*
    attribute :success_url, String

    # Redirect URL in case of error. This setting overrides your Jumio merchant
    # settings. We strongly recommend providing an HTTPS URL using the TLS
    # protocol (ports are not allowed).
    #
    # *Mandatory if not specified in your Jumio merchant settings.*
    attribute :error_url, String

    ##############################
    # OPTIONAL
    ##############################

    # Time in seconds until the authorization token expires
    # Default: 300 seconds
    # 0: Unused authorization token never expires
    attribute :authorization_token_lifetime, String, default: nil

    # Your reporting criteria for each scan
    attribute :merchant_reporting_criteria, String, default: nil

    # Callback URL for the confirmation after the verification is completed.
    # This setting overrides your Jumio merchant settings. Provide an HTTPS URL
    # using the TLS protocol (ports are not allowed).
    attribute :callback_url, String, default: nil

    # IP address of the client
    attribute :client_ip, String, default: nil

    def response
      response_json = run_request!

      MultiDocumentResponse.new(response_json)
    end

    private

    def endpoint_url
      'https://netverify.com/api/netverify/v2/createDocumentAcquisition'
    end
  end
end
