require "rails_helper"

describe Nexaas::Async::Collector::InMemoryStorage do
  let(:redis) { Redis.new }
  subject { described_class.new('redis://test.local') }

  describe "#get" do
    before { subject.set("foo", "bar") }

    it 'gets value from redis' do
      expect(subject.get("foo")).to eq("bar")
    end
  end

  describe "#set" do
    it 'writes data in redis' do
      subject.set("foo", "land")
      expect(subject.get("foo")).to eq("land")
    end
  end
end
