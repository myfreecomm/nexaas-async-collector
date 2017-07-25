require "rails_helper"

class DummyAsyncResource
  def generate(n1, n2); end
end

describe Nexaas::Async::Collector::ApplicationHelper, type: :helper do
  describe "#nexaas_async_collect" do
    let(:data) do
      {
        scope_id: 12, class_name: DummyAsyncResource,
        class_method: :generate, args: [1, 4]
      }
    end

    before { allow(SecureRandom).to receive(:hex).and_return("abc123") }

    it 'renders nexaas/async/collector/async_resource/show partial' do
      allow_any_instance_of(Nexaas::Async::Collector::AsyncResource).to receive(:collect_id) { '123321' }
      expect(helper).to receive(:render).with({
        partial: 'nexaas/async/collector/async_resource/show',
        locals: {
          unique_id: 'abc123', collect_id: '123321'
        }
      })
      helper.nexaas_async_collect(data)
    end

    it 'returns valid code from partial' do
      expect(
        helper.nexaas_async_collect(data)
      ).to match(/<script type=/)
    end

    it 'invokes Nexaas::Async::Collector::AsyncResource.save!' do
      expect_any_instance_of(Nexaas::Async::Collector::AsyncResource).to receive(:save!).and_call_original
      helper.nexaas_async_collect(data)
    end
  end

  describe '#nexaas_async_collector' do
    it "should respond to engine url methods" do
      expect(helper.nexaas_async_collector).to respond_to(:async_resource_path)
    end
  end
end
