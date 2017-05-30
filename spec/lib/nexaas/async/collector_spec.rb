require 'spec_helper'

describe Nexaas::Async::Collector do
  it 'has a version number' do
    expect(Nexaas::Async::Collector::VERSION).to_not be_nil
  end

  describe '.configure' do
    it 'accepts a block to configure gem options' do
      described_class.configure do |c|
        c.redis_url = 'anything'
        c.redis_namespace = 'specific_namespace'
      end

      config = described_class.configuration
      expect(config.redis_url).to eq('anything')
      expect(config.redis_namespace).to eq('specific_namespace')
    end
  end

  describe '.configuration' do
    it 'returns a memoized object' do
      first_config = described_class.configuration
      first_config.redis_namespace = 'my_specific_namespace'

      config = described_class.configuration
      expect(config.redis_namespace).to eq('my_specific_namespace')
    end
  end
end
