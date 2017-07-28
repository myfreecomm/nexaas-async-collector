require "rails_helper"

describe Nexaas::Async::Collector::Persist do
  describe ".save" do
    let!(:expiration) { Nexaas::Async::Collector.expiration }
    let(:opts) do
      {
        scope_id: '123', collect_id: 'abcdf',
        content: '<html></html>'
      }
    end

    it 'instantiates a new Storage object' do
      expect(Nexaas::Async::Collector::Storage).to receive(:new) { double(set: true) }
      described_class.save(opts)
    end

    it 'invokes Storage#set' do
      expect_any_instance_of(Nexaas::Async::Collector::Storage).to receive(:set).with('abcdf', {
        scope_id: '123',
        content: Base64.encode64('<html></html>'),
        file: nil
      }.to_json, expiration)
      described_class.save(opts)
    end

    context 'when file option is present' do
      before { opts[:file] = { content_type: 'text/html', name: 'index' } }

      it 'invokes Storage#set' do
        expect_any_instance_of(Nexaas::Async::Collector::Storage).to receive(:set).with('abcdf', {
          scope_id: '123',
          content: Base64.encode64('<html></html>'),
          file: { content_type: 'text/html', name: 'index' }
        }.to_json, expiration)
        described_class.save(opts)
      end
    end

    context 'when expiration option is set by user globally' do
      before { Nexaas::Async::Collector.expiration = 200 }
      after { Nexaas::Async::Collector.expiration = expiration }

      it 'invokes Storage#set with expiration set by user' do
        expect_any_instance_of(Nexaas::Async::Collector::Storage).to receive(:set).with('abcdf', {
          scope_id: '123',
          content: Base64.encode64('<html></html>'),
          file: nil
        }.to_json, 200)
        described_class.save(opts)
      end
    end

    context 'when expiration option is set by user locally (as option)' do
      it 'invokes Storage#set with expiration set by user' do
        expect_any_instance_of(Nexaas::Async::Collector::Storage).to receive(:set).with('abcdf', {
          scope_id: '123',
          content: Base64.encode64('<html></html>'),
          file: nil
        }.to_json, 50)
        described_class.save(opts.merge(expiration: 50))
      end
    end
  end
end
