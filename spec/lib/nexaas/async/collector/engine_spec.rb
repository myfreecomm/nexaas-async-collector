require 'rails_helper'

describe Nexaas::Async::Collector::Engine do
  it 'provides its helpers to the app controller defined as parent_class configuration' do
    expect(Nexaas::Async::Collector.parent_controller.constantize.helpers).to respond_to(:nexaas_async_collect)
  end
end
