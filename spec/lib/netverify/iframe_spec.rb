module Netverify
  describe Iframe do
    subject { described_class.new(params) }

    let(:endpoint_url) { api_url 'api/netverify/v2/initiateNetverify' }
    let(:params) do
      {
        success_url: 'http://example.com/success',
        error_url: 'http://example.com/error',
        customer_id: '1234'
      }
    end
    let(:valid_request_body) do
      {
        successUrl: 'http://example.com/success',
        errorUrl: 'http://example.com/error',
        merchantIdScanReference: 'random-uuid',
        customerID: '1234'
      }
    end

    before do
      allow(SecureRandom).to receive(:uuid).and_return('random-uuid')
    end

    describe '#response' do
      let(:result) { subject.response }

      context 'with all required params' do
        before do
          stub_request(:post, endpoint_url).with(body: valid_request_body).
            to_return(body: { authorizationToken: 'auth-1234' }.to_json)
        end

        it 'sends request to Netverify API' do
          result

          expect(WebMock).to have_requested(:post, endpoint_url).
                               with(body: valid_request_body)
        end

        it 'returns instance of IframeResponse' do
          expect(result).to be_instance_of(IframeResponse)
        end

        it 'initializes IframeResponse with correct params' do
          expect(result.authorization_token).to eq 'auth-1234'
        end
      end

      context 'with required attribute missing' do
        let(:params) { Hash.new }
        let(:response_body) { { message: 'some error' }.to_json }
        let(:invalid_request_body) do
          { merchantIdScanReference: 'random-uuid' }
        end

        before do
          stub_request(:post, endpoint_url).with(body: invalid_request_body).
            to_return(body: response_body, status: 400)
        end

        it 'raises HTTPClient::ResponseError' do
          expect { result }.
            to raise_error(HTTPClient::ResponseError, response_body)
        end
      end
    end
  end
end
