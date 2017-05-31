require "rails_helper"

class DummyAsyncResource
  def generate(n1, n2); end
end

describe Nexaas::Async::Collector::ApplicationHelper, type: :helper do
  describe "#nexaas_async_collect" do
    before { allow(SecureRandom).to receive(:hex).and_return("abc123") }

    it "enqueues Nexaas::Async::Collector::AsyncResourceJob job" do
      expect(Nexaas::Async::Collector::AsyncResourceJob).to receive(:perform_async).with("abc123", 12, DummyAsyncResource, :generate, [1, 4])
      helper.nexaas_async_collect(12, DummyAsyncResource, :generate, [1, 4])
    end

    it 'renders nexaas/async/collector/async_resource/show partial' do
      expect(helper).to receive(:render)
      helper.nexaas_async_collect(12, DummyAsyncResource, :generate, [1, 4])
    end

    it 'returns valid code from partial' do
      expect(
        helper.nexaas_async_collect(12, DummyAsyncResource, :generate, [1, 4])
      ).to match(/<script type=/)
    end
  end
end
