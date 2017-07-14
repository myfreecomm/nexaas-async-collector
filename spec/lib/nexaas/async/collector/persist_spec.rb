require "rails_helper"

describe Nexaas::Async::Collector::Persist do
  describe ".save" do
    let(:scope_id) { '123' }
    let(:key) { 'abcdf' }
    let(:value) { 'specific-value' }
    let(:content) {
      {
        'scope_id' => scope_id,
        'content' => value
      }.to_json
    }

    it 'instantiates a new InMemoryStorage object' do
      expect(Nexaas::Async::Collector::InMemoryStorage).to receive(:new) { double(set: true) }
      described_class.save(scope_id, key, value)
    end

    it 'invokes InMemoryStorage#set' do
      expect_any_instance_of(Nexaas::Async::Collector::InMemoryStorage).to receive(:set).with(key, content)
      described_class.save(scope_id, key, value)
    end
  end
end
