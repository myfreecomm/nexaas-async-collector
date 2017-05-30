Rails.application.routes.draw do
  get 'nexaas/async/collect/:id' => 'nexaas/async/collector/async_resource#show', as: :nexaas_async_collect
end
