module Netverify
  describe MultiDocumentResponse do
    subject { described_class.new(params) }

    let(:authorization_token) { 'auth-token-1234' }
    let(:params) do
      {
        authorization_token: authorization_token
      }
    end

    describe '#script_tag' do
      it 'contains authorization token returned from API' do
        expect(subject.script_tag).to include authorization_token
      end

      it 'uses passed container_id to initialize verification' do
        expect(subject.script_tag(container_id: 'SOME_ID')).
          to include 'initMDM("SOME_ID")'
      end

      it 'uses passed locale' do
        expect(subject.script_tag(locale: 'so')).to include 'locale: "so"'
      end
    end
  end
end
