require "rails_helper"

RSpec.describe Nexaas::Async::Collector::AsyncResourceController, type: :routing do
  routes { Nexaas::Async::Collector::Engine.routes }

  describe "#show" do
    it { expect(get: '/async_resource/9').to route_to(controller: 'nexaas/async/collector/async_resource', action: 'show', id: '9') }

    it { expect(async_resource_path(12345)).to eq('/nexaas_async_collect/async_resource/12345') }
  end
end
