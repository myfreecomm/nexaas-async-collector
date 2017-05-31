require 'rails_helper'

describe Nexaas::Async::Collector::AsyncResourceController, type: :controller do
  before { allow(controller).to receive(:current_nac_resource).and_return(double(id: 123)) }

  describe "GET show" do
    it 'instantiates a new result object' do
      xhr_request :get, :show, id: '12345'
      expect(assigns(:result)).to be_kind_of(Nexaas::Async::Collector::Result)
    end

    it 'instantiates the result object with correct data' do
      expect(Nexaas::Async::Collector::Result).to receive(:new).with(123, '12345')
      xhr_request :get, :show, id: '12345'
    end
  end
end
