module Netverify
  class IframeResponse < Response

    WIDGET_URL =
      'https://netverify.com/widget/jumio-verify/2.0/iframe-script.js'

    # Timestamp of the response in the format YYYY-MM-DDThh:mm:ss.SSSZ
    attribute :timestamp, String

    # Authorization token, which is valid for the authorization token lifetime
    attribute :authorization_token, String

    # Jumio's reference number for each scan
    attribute :jumio_id_scan_reference, String

    def script_tag(container_id: 'JUMIOIFRAME')
      <<-SCRIPT.strip_heredoc
        <script src="#{WIDGET_URL}"></script>
        <script>
          JumioClient.setVars({
            authorizationToken: "#{authorization_token}"
          }).initVerify("#{container_id}");
        </script>
      SCRIPT
    end
  end
end
