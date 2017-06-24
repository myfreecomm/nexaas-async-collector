Rails.application.routes.draw do
  mount Nexaas::Async::Collector::Engine => '/nexaas_async_collect'
end
