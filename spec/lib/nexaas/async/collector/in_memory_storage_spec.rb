require "rails_helper"

describe Nexaas::Async::Collector::InMemoryStorage do
  subject { described_class.new }

  describe "#get" do
    before { subject.set("foo", "bar") }

    it 'uses sidekiq shared redis pool' do
      expect(Sidekiq).to receive(:redis_pool).and_call_original
      subject.get("foo")
    end

    it 'gets value from redis' do
      expect(subject.get("foo")).to eq("bar")
    end
  end

  describe "#set" do
    it 'uses sidekiq shared redis pool' do
      expect(Sidekiq).to receive(:redis_pool).and_call_original
      subject.set("foo", "bar")
    end

    it 'writes data in redis' do
      subject.set("foo", "land")
      expect(subject.get("foo")).to eq("land")
    end
  end
end
