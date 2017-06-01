require "rails_helper"

describe Nexaas::Async::Collector::Result do
  let(:redis) { Redis.new }
  let(:not_ready_content) {
    { 'user_id' => 1892, 'content' => nil }.to_json
  }
  let(:ready_content) {
    { 'user_id' => 1893, 'content' => '<html></html>' }.to_json
  }

  before do
    redis.set("foo-ready", ready_content)
    redis.set("foo-not-ready", not_ready_content)
    allow(subject).to receive(:storage).and_return(redis)
  end

  describe "#content_is_ready?" do
    context "when content is ready" do
      context "when user_id is correctly" do
        subject { described_class.new(1893, 'foo-ready') }

        it { expect(subject.content_is_ready?).to be_truthy }
      end

      context "when user_id is not correctly" do
        subject { described_class.new(1892, 'foo-ready') }

        it { expect(subject.content_is_ready?).to be_falsy }
      end
    end

    context "when content is not ready" do
      context "when user_id is correctly" do
        subject { described_class.new(1892, 'foo-not-ready') }

        it { expect(subject.content_is_ready?).to be_falsy }
      end

      context "when user_id is not correctly" do
        subject { described_class.new(1893, 'foo-not-ready') }

        it { expect(subject.content_is_ready?).to be_falsy }
      end
    end
  end

  describe "#content" do
    context "when content is ready" do
      context "when user_id is correctly" do
        subject { described_class.new(1893, 'foo-ready') }

        it { expect(subject.content).to eq('<html></html>') }
      end

      context "when user_id is not correctly" do
        subject { described_class.new(1892, 'foo-ready') }

        it { expect(subject.content).to be_nil }
      end
    end

    context "when content is not ready" do
      context "when user_id is correctly" do
        subject { described_class.new(1892, 'foo-not-ready') }

        it { expect(subject.content).to be_nil }
      end

      context "when user_id is not correctly" do
        subject { described_class.new(1893, 'foo-not-ready') }

        it { expect(subject.content).to be_nil }
      end
    end
  end
end
