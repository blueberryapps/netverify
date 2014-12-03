module Netverify
  describe StringCamelizer do
    subject { described_class.new(my_house: 'MYRules') }

    it 'uses String#camelize with first letter downcased' do
      expect(subject.camelize :some_key).to eq 'someKey'
    end

    it 'rules can be overriden by hash passed to constructor' do
      expect(subject.camelize :my_house).to eq 'MYRules'
    end
  end
end
