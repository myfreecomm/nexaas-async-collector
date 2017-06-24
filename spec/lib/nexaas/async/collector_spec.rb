require 'rails_helper'

describe Nexaas::Async::Collector do
  it 'has a version number' do
    expect(Nexaas::Async::Collector::VERSION).to_not be_nil
  end

  describe '.redis_url' do
    it { expect(described_class.redis_url).to be_nil }
  end

  describe '.redis_namespace' do
    it { expect(described_class.redis_namespace).to eq('nexaas_async') }
  end

  describe '.queue_name' do
    it { expect(described_class.queue_name).to eq(:high_fast) }
  end

  describe '.scope' do
    it { expect(described_class.scope).to eq('current_user') }
  end

  describe '.parent_controller' do
    it { expect(described_class.parent_controller).to eq('::ActionController::Base') }
  end

  describe '.configure' do
    it 'accepts a block to configure gem options' do
      described_class.configure do |c|
        c.redis_url = 'anything'
        c.redis_namespace = 'specific_namespace'
        c.queue_name = 'faster'
      end

      expect(described_class.redis_url).to eq('anything')
      expect(described_class.redis_namespace).to eq('specific_namespace')
      expect(described_class.queue_name).to eq('faster')
    end
  end
end
