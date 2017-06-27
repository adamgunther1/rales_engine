Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :invoice_items, only: [:index, :show]
    end
  end
end
