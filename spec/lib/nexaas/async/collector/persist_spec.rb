require "rails_helper"

describe Nexaas::Async::Collector::Persist do
  describe ".save" do
    let(:opts) do
      {
        scope_id: '123', collect_id: 'abcdf',
        content: '<html></html>'
      }
    end

    it 'instantiates a new InMemoryStorage object' do
      expect(Nexaas::Async::Collector::InMemoryStorage).to receive(:new) { double(set: true) }
      described_class.save(opts)
    end

    it 'invokes InMemoryStorage#set' do
      expect_any_instance_of(Nexaas::Async::Collector::InMemoryStorage).to receive(:set).with('abcdf', {
        'scope_id' => '123',
        'content' => Base64.encode64('<html></html>'),
        'file' => nil
      }.to_json)
      described_class.save(opts)
    end

    context 'when file option is present' do
      before { opts[:file] = { content_type: 'text/html', name: 'index' } }

      it 'invokes InMemoryStorage#set' do
        expect_any_instance_of(Nexaas::Async::Collector::InMemoryStorage).to receive(:set).with('abcdf', {
          scope_id: '123',
          content: Base64.encode64('<html></html>'),
          file: { content_type: 'text/html', name: 'index' }
        }.to_json)
        described_class.save(opts)
      end
    end
  end
end
