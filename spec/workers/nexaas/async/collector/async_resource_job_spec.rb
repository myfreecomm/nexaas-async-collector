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
    let(:opts) do
      {
        collect_id: 'id-hash', scoped_id: 12,
        class_name: 'DummyModel', class_method: :generate,
        args: [4, 5]
      }
    end

    context 'when instrumentation_context param is not present' do
      it 'instruments start with ActiveSupport::Notifications' do
        Timecop.freeze(2017, 7, 13, 10, 0, 0) do
          allow(subject).to receive(:instrument_finish)
          expect(ActiveSupport::Notifications).to receive(:instrument).with(
            "nexaas-async-collector.start", {
            collect_id: 'id-hash', scoped_id: 12,
            class_name: 'DummyModel', class_method: :generate,
            start: 1499940000
          })
          subject.perform(opts)
        end
      end

      it 'instruments finish with ActiveSupport::Notifications' do
        Timecop.freeze(2017, 7, 13, 10, 0, 0) do
          allow(subject).to receive(:instrument_start)
          expect(ActiveSupport::Notifications).to receive(:instrument).with(
            "nexaas-async-collector.finish", {
            collect_id: 'id-hash', scoped_id: 12,
            class_name: 'DummyModel', class_method: :generate,
            finish: 1499940000, duration: 0
          })
          subject.perform(opts)
        end
      end
    end

    context "when instrumentation_context param is present" do
      it 'instruments start ActiveSupport::Notifications' do
        Timecop.freeze(2017, 7, 13, 10, 0, 0) do
          allow(subject).to receive(:instrument_finish)
          expect(ActiveSupport::Notifications).to receive(:instrument).with(
            "custom.instrumentation.start", {
            collect_id: 'id-hash', scoped_id: 12,
            class_name: 'DummyModel', class_method: :generate,
            start: 1499940000
          })
          subject.perform(opts.merge(instrumentation_context: 'custom.instrumentation'))
        end
      end

      it 'instruments finish with ActiveSupport::Notifications' do
        Timecop.freeze(2017, 7, 13, 10, 0, 0) do
          allow(subject).to receive(:instrument_start)
          expect(ActiveSupport::Notifications).to receive(:instrument).with(
            "custom.instrumentation.finish", {
            collect_id: 'id-hash', scoped_id: 12,
            class_name: 'DummyModel', class_method: :generate,
            finish: 1499940000, duration: 0
          })
          subject.perform(opts.merge(instrumentation_context: 'custom.instrumentation'))
        end
      end
    end

    context "when there are additional args" do
      it 'invokes Persist.save' do
        expect(Nexaas::Async::Collector::Persist).to receive(:save)
        subject.perform(opts)
      end

      it 'invokes DummyModel.generate' do
        allow(Nexaas::Async::Collector::Persist).to receive(:save)
        expect(DummyModel).to receive(:generate).with(4, 5)
        subject.perform(opts)
      end
    end

    context "when there is no additional args" do
      before { opts.merge!(class_method: :update).delete(:args) }

      it 'invokes Persist.save' do
        expect(Nexaas::Async::Collector::Persist).to receive(:save)
        subject.perform(opts)
      end

      it 'invokes DummyModel.update' do
        allow(Nexaas::Async::Collector::Persist).to receive(:save)
        expect(DummyModel).to receive(:update).with(no_args)
        subject.perform(opts)
      end
    end
  end
end
