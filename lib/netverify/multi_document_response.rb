module Netverify
  class MultiDocumentResponse < Response

    WIDGET_URL =
      'https://netverify.com/widget/jumio-verify/2.0/iframe-script.js'

    # Jumio’s reference number for each scan
    attribute :jumio_scan_reference, String

    # Authorization token, which is valid for the authorization token lifetime
    attribute :authorization_token, String

    # Timestamp of the response in the format YYYY-MM-DDThh:mm:ss.SSSZ
    attribute :timestamp, String

    def script_tag(container_id: 'JUMIOMDMIFRAME', locale: nil)
      <<-SCRIPT.strip_heredoc
        <script src="#{WIDGET_URL}" type="text/javascript"></script>
        <script type="text/javascript">
          JumioClient.setVars({
            authorizationToken: #{authorization_token.to_json},
            locale: #{locale.to_json}
          }).initMDM("#{container_id}");
        </script>
      SCRIPT
    end
  end
end
