require 'rails_helper'

describe Nexaas::Async::Collector::AsyncResourceController, type: :controller do
  describe "GET show" do
    context "when scope configuration is as default" do # invokes current_user method
      it 'instantiates the result object with correct data' do
        allow(controller).to receive(:current_user) { double(id: 1234) }
        expect(Nexaas::Async::Collector::Result).to receive(:new).with(1234, 'abcde')
        xhr_request :get, :show, id: 'abcde'
      end
    end

    context "when scope configuration is as default" do
      before do
        Nexaas::Async::Collector.configure do |c|
          c.scope = :current_resource
        end
      end

      it 'instantiates the result object with correct data' do
        allow(controller).to receive(:current_resource) { double(id: 1234) }
        expect(Nexaas::Async::Collector::Result).to receive(:new).with(1234, 'abcde')
        xhr_request :get, :show, id: 'abcde'
      end
    end
  end
end
