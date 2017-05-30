require 'rails_helper'

describe Nexaas::Async::Collector::Configuration do
  it 'instantiates object with default values' do
    object = described_class.new
    expect(object.redis_url).to eq(nil)
    expect(object.redis_namespace).to eq('nexaas_async')
  end

  context 'when REDIS_URL env variable is set' do
    before { ENV.store('REDIS_URL', 'redis://test.local') }
    after { ENV.store('REDIS_URL', nil) }

    it 'uses REDIS_URL variable' do
      object = described_class.new
      expect(object.redis_url).to eq('redis://test.local')
      expect(object.redis_namespace).to eq('nexaas_async')
    end
  end
end
