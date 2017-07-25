require 'rails_helper'

describe Nexaas::Async::Collector::AsyncResource do
  let(:attr) do
    {
      scope_id: 1, class_name: 'DummyModel',
      class_method: :generate, args: [1,2,3],
      file: { content_type: 'application/json', name: 'json-file' },
      collect_id: 'abcdef', instrumentation_context: 'custom.instrumentation'
    }
  end

  subject { described_class.new(attr) }

  describe 'object attributes' do
    it { is_expected.to respond_to(:scope_id) }
    it { is_expected.to respond_to(:class_name) }
    it { is_expected.to respond_to(:class_method) }
    it { is_expected.to respond_to(:args) }
    it { is_expected.to respond_to(:file) }
    it { is_expected.to respond_to(:collect_id) }
  end

  describe '#save!' do
    context 'when attributes are valid' do
      it { expect(subject.save!).to be_truthy }

      it 'enqueues Nexaas::Async::Collector::AsyncResourceJob' do
        expect(Nexaas::Async::Collector::AsyncResourceJob).to receive(:perform_async).with(attr)
        subject.save!
      end
    end

    context 'when attributes are not valid' do
      before do
        attr.delete(:scope_id)
        attr.delete(:class_name)
      end

      it 'raises an error' do
        expect { subject.save! }.to raise_error("Nexaas::Async::Collector: invalid fields scope_id, class_name")
      end

      it 'does not enqueue Nexaas::Async::Collector::AsyncResourceJob' do
        expect(Nexaas::Async::Collector::AsyncResourceJob).to_not receive(:perform_async)
        lambda { subject.save! }
      end
    end
  end

  describe '#sliced_attributes' do
    subject { described_class.new(attr) }

    it 'returns sliced attributes' do
      expect(subject.sliced_attributes).to eq(attr)
    end

    context 'when any attribute is nil' do
      before { attr[:file] = nil }

      it 'ignores it' do
        expect(subject.sliced_attributes).to eq({
          scope_id: 1, class_name: 'DummyModel',
          class_method: :generate, args: [1,2,3],
          collect_id: 'abcdef',
          instrumentation_context: 'custom.instrumentation'
        })
      end
    end
  end
end