require_relative 'iframe_response'

module Netverify
  class Iframe < Embedded

    ##############################
    # REQUIRED
    ##############################

    # Your reference for each scan must not contain sensitive
    # data like email address or account login
    attribute :merchant_id_scan_reference, String, default: :generate_random_id

    # Redirect URL in case of success. This setting overrides your Jumio
    # merchant settings. We strongly recommend providing an HTTPS URL using
    # the TLS protocol (ports are not allowed).
    # *Mandatory if not specified in your Jumio merchant settings.*
    attribute :success_url, String

    # Redirect URL in case of error. This setting overrides your Jumio merchant
    # settings. We strongly recommend providing an HTTPS URL using the TLS
    # protocol (ports are not allowed). * Mandatory if not specified in your
    # Jumio merchant settings.
    attribute :error_url, String

    ##############################
    # OPTIONAL
    ##############################

    # Defines which fields must be processed during the ID verification. This
    # setting overrides your Jumio merchant settings. List of field separeted
    # comma.
    #
    # Possible values:
    #   - idNumber
    #   - idFirstName
    #   - idLastName
    #   - idDob
    #   - idExpiry
    #   - idUsState
    #   - idPersonalNumber
    #   - idFaceMatch
    #   - idAddress
    attribute :enabled_fields, String, default: nil

    # Time in seconds until the authorizationToken expires
    # Default: 300 seconds
    # 0: Unused authorization token never expires
    attribute :authorization_token_lifetime, Integer, default: nil

    # Your reporting criteria for each scan
    attribute :merchant_reporting_criteria, String, default: nil

    # Callback URL for the confirmation after the verification is completed.
    # This setting overrides your Jumio merchant settings. Provide an HTTPS URL
    # using the TLS protocol (ports are not allowed).
    attribute :callback_url, String, default: nil

    # Locale of the Netverify client.
    # Possible values:
    #  - "cs" (Czech)
    #  - "de" (German)
    #  - "en" (American English, default)
    #  - "en_GB" (British English)
    #  - "es" (Spanish)
    #  - "fi" (Finnish)
    #  - "fr" (French)
    #  - "it" (Italian)
    #  - "no" (Norwegian)
    #  - "pl" (Polish)
    #  - "pt" (Portuguese)
    #  - "ru" (Russian)
    #  - "sv" (Swedish)
    #  - "tr" (Turkish)
    attribute :locale, String, default: nil

    # IP address of the client
    attribute :client_ip, String, default: nil

    # Identification of the customer should not contain sensitive data like
    # email address or account login
    attribute :customer_id, String, default: nil

    # First name of the customer
    attribute :first_name, String, default: nil

    # Last name of the customer
    attribute :last_name, String, default: nil

    # ISO 3166-1 alpha-3 country code
    attribute :country, String, default: nil

    # If idType = DRIVING_LICENSE:
    #   - Last two characters of ISO 3166-2:US state code
    #
    # Possible values if idType = PASSPORT or idType = ID_CARD:
    #   - Last two characters of ISO 3166-2:US state code
    #   - ISO 3166-1 country name
    #   - ISO 3166-1 alpha-2 country code
    #   - ISO 3166-1 alpha-3 country code
    attribute :us_state, String, default: nil

    # Date of expiry in the format yyyy-mm-dd
    attribute :expiry, String, default: nil

    # Identification number of the document
    attribute :number, String, default: nil

    # Date of birth in the format yyyy-mm-dd
    attribute :dob, String, default: nil

    # PASSPORT, DRIVING_LICENSE, ID_CARD
    attribute :id_type, String, default: nil

    # Personal number of the document
    attribute :personal_number, String, default: nil

    # Enable or disable the MRZ check. This setting overrides your Jumio
    # merchant settings. To perform the MRZ check, the fields date of birth,
    # expiry and personal number will be processed during the ID verification,
    # if available on the ID.
    attribute :mrz_check, Boolean, default: nil

    # Additional information for this scan should not contain sensitive data
    # like email address or account login
    attribute :additional_information, String, default: nil

    def response
      http_response = run_request!
      IframeResponse.new(http_response)
    end

    private

    def endpoint_url
      'https://netverify.com/api/netverify/v2/initiateNetverify'
    end
  end
end
