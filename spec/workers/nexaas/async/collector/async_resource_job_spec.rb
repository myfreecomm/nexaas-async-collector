require 'rails_helper'
require 'sidekiq/testing'

class DummyModel
  def self.generate(first_arg, second_arg)
    first_arg + second_arg
  end

  def self.update
    "Updated!"
  end
end

describe Nexaas::Async::Collector::AsyncResourceJob do
  subject { described_class.new }

  it 'uses the correct queue name' do
    expect { described_class.perform_async }.to change(Sidekiq::Queues['high_fast'], :size).by(1)
  end

  describe "#perform" do
    context "when there are additional args" do
      it 'invokes Persist.save' do
        expect(Nexaas::Async::Collector::Persist).to receive(:save)
        subject.perform("id-hash", 12, 'DummyModel', :generate, [4, 5])
      end

      it 'invokes DummyModel.generate' do
        allow(Nexaas::Async::Collector::Persist).to receive(:save)
        expect(DummyModel).to receive(:generate).with(4, 5)
        subject.perform("id-hash", 12, 'DummyModel', :generate, [4, 5])
      end
    end

    context "when there is no additional args" do
      it 'invokes Persist.save' do
        expect(Nexaas::Async::Collector::Persist).to receive(:save)
        subject.perform("id-hash", 12, 'DummyModel', :update)
      end

      it 'invokes DummyModel.update' do
        allow(Nexaas::Async::Collector::Persist).to receive(:save)
        expect(DummyModel).to receive(:update).with(no_args)
        subject.perform("id-hash", 12, 'DummyModel', :update)
      end
    end
  end
end
