module Netverify
  describe MultiDocumentIframe do
    subject { described_class.new(params) }

    let(:endpoint_url) { api_url 'api/netverify/v2/createDocumentAcquisition' }
    let(:params) do
      {
        document_type: 'BS',
        customer_id:   '1234',
        success_url:   'http://example.com/success',
        error_url:     'http://example.com/error'
      }
    end
    let(:valid_request_body) do
      {
        documentType:          'BS',
        merchantScanReference: 'random-uuid',
        customerID:            '1234',
        successUrl:            'http://example.com/success',
        errorUrl:              'http://example.com/error'
      }
    end

    before do
      allow(SecureRandom).to receive(:uuid).and_return('random-uuid')
    end

    describe '#response' do
      context 'with all required params' do
        let(:result) { subject.response }

        before do
          stub_request(:post, endpoint_url).with(body: valid_request_body).
            to_return(body: { authorizationToken: 'auth-1234' }.to_json)
        end

        it 'sends request to Netverify API' do
          result

          expect(WebMock).to have_requested(:post, endpoint_url).
                               with(body: valid_request_body)
        end

        it 'returns instance of MultiDocumentResponse' do
          expect(result).to be_instance_of(MultiDocumentResponse)
        end

        it 'initializes MultiDocumentResponse with correct params' do
          expect(result.authorization_token).to eq 'auth-1234'
        end
      end
    end
  end
end
