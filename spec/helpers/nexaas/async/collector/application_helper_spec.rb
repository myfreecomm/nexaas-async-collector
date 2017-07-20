require "rails_helper"

class DummyAsyncResource
  def generate(n1, n2); end
end

describe Nexaas::Async::Collector::ApplicationHelper, type: :helper do
  describe "#nexaas_async_collect" do
    before { allow(SecureRandom).to receive(:hex).and_return("abc123") }

    it "enqueues Nexaas::Async::Collector::AsyncResourceJob job" do
      expect(Nexaas::Async::Collector::AsyncResourceJob).to receive(:perform_async).with({ collect_id: "abc123", scope_id: 12, class_name: DummyAsyncResource, class_method: :generate, args: [1, 4] })
      helper.nexaas_async_collect({ scope_id: 12, class_name: DummyAsyncResource, class_method: :generate, args: [1, 4] })
    end

    it 'renders nexaas/async/collector/async_resource/show partial' do
      expect(helper).to receive(:render).with({ partial: 'nexaas/async/collector/async_resource/show', locals: { unique_id: 'abc123' } })
      helper.nexaas_async_collect({ scope_id: 12, class_name: DummyAsyncResource, class_method: :generate, args: [1, 4] })
    end

    it 'returns valid code from partial' do
      expect(
        helper.nexaas_async_collect({ scope_id: 12, class_name: DummyAsyncResource, class_method: :generate, args: [1, 4] })
      ).to match(/<script type=/)
    end

    context 'when missing required parameters' do
      let(:params) { { args: [1, 4] } }

      it 'raises exception' do
        expect {
          helper.nexaas_async_collect(params)
        }.to raise_error("Nexaas::Async::Collector: Required parameter missing: scope_id, class_name, class_method")
      end

      it 'does not enqueue Nexaas::Async::Collector::AsyncResourceJob job' do
        expect(Nexaas::Async::Collector::AsyncResourceJob).to_not receive(:perform_async)
        lambda { helper.nexaas_async_collect(params) }
      end
    end
  end

  describe '#nexaas_async_collector' do
    it "should respond to engine url methods" do
      expect(helper.nexaas_async_collector).to respond_to(:async_resource_path)
    end
  end
end
