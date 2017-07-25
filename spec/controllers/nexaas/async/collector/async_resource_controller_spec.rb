require 'rails_helper'

describe Nexaas::Async::Collector::AsyncResourceController, type: :controller do
  routes { Nexaas::Async::Collector::Engine.routes }

  describe "GET show" do
    it 'assigns unique_id as infomed' do
      allow(controller).to receive(:current_user) { double(id: 1234) }
      xhr_request :get, :show, id: 'abcde', unique_id: 'abcdef'
      expect(assigns(:unique_id)).to eq('abcdef')
    end

    it 'instantiates Result object' do
      allow(controller).to receive(:current_user) { double(id: 1234) }
      xhr_request :get, :show, id: 'abcde', unique_id: 'abcdef'
      expect(assigns(:result)).to be_instance_of(Nexaas::Async::Collector::Result)
    end

    it 'renders show template' do
      allow(controller).to receive(:current_user) { double(id: 1234) }
      xhr_request :get, :show, id: 'abcde', unique_id: 'abcdef'
      expect(response).to render_template('nexaas/async/collector/async_resource/show')
    end

    context "when format is different from js" do
      context "when data is ready" do
        let(:result) do
          double({
            content_is_ready?: true, filename: 'testing',
            content_type: 'application/json', extension: 'json',
            content: '{}'
          })
        end

        before do
          allow(controller).to receive(:current_user) { double(id: 1234) }
          allow(Nexaas::Async::Collector::Result).to receive(:new) { result }
        end

        it 'sends data in stream' do
          expect(controller).to receive(:send_data).with('{}', {
            filename: result.filename, type: result.content_type,
            disposition: 'attachment'
          }).and_call_original
          send_request :get, :show, id: 'abcde', unique_id: 'abcdef', format: 'json'
        end
      end
    end

    context "when scope configuration is as default" do # invokes current_user method
      it 'instantiates the result object with correct data' do
        allow(controller).to receive(:current_user) { double(id: 1234) }
        expect(Nexaas::Async::Collector::Result).to receive(:new).with(1234, 'abcde')
        xhr_request :get, :show, id: 'abcde'
      end
    end

    context "when scope configuration is not as default" do
      before do
        @default_scope = Nexaas::Async::Collector.scope
        Nexaas::Async::Collector.configure { |c| c.scope = 'current_resource' }
      end

      after do
        Nexaas::Async::Collector.configure { |c| c.scope = @default_scope }
      end

      it 'instantiates the result object with correct data' do
        allow(controller).to receive('current_resource') { double(id: 1234) }
        expect(Nexaas::Async::Collector::Result).to receive(:new).with(1234, 'abcde')
        xhr_request :get, :show, id: 'abcde'
      end
    end

    context "when parent_controller configuration is as default" do
      subject { controller }

      it { is_expected.to be_kind_of(::ActionController::Base) }
    end

    context "when parent_controller configuration is not as default" do
      def reload_controllers
        Nexaas::Async::Collector.send(:remove_const, 'ApplicationController')
        Nexaas::Async::Collector.send(:remove_const, 'AsyncResourceController')
        load 'app/controllers/nexaas/async/collector/application_controller.rb'
        load 'app/controllers/nexaas/async/collector/async_resource_controller.rb'
      end

      subject { Nexaas::Async::Collector::AsyncResourceController.new }

      before do
        @default_parent_controller = Nexaas::Async::Collector.parent_controller
        Nexaas::Async::Collector.configure { |c| c.parent_controller = '::OtherController' }
        reload_controllers
      end

      after do
        Nexaas::Async::Collector.configure { |c| c.parent_controller = @default_parent_controller }
        reload_controllers
      end

      it { is_expected.to be_kind_of(::OtherController) }
      it { is_expected.to respond_to(:other_dummy_action) }
      it { is_expected.to_not respond_to(:application_dummy_action) }
    end
  end
end
