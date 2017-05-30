require "rails_helper"

RSpec.describe Nexaas::Async::Collector::AsyncResourceController, type: :routing do
  describe "#show" do
    it { expect(get: '/nexaas/async/collect/2333').to route_to(controller: 'nexaas/async/collector/async_resource', action: 'show', id: '2333') }
    it { expect(nexaas_async_collect_path('12345')).to eq('/nexaas/async/collect/12345') }
  end
end
