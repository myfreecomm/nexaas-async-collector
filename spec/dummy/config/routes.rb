Rails.application.routes.draw do
  mount Nexaas::Async::Collector::Engine => "/async"
end
