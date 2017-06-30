Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
        get '/revenue', to: 'revenue#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/most_items', to: 'most_items#index'
        get '/most_revenue', to: 'most_revenue#index'      
        get '/:id/customers_with_pending_invoices', to: 'customers_with_pending_invoices#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/random', to: 'random#show'
      end

      namespace :customers do
        get '/:id/favorite_merchant', to: 'favorite_merchant#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :items do
        get '/:id/best_day', to: 'best_day#index' 
        get '/most_items', to: 'most_items#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
      end

      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
      end

      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
      end

      namespace :transactions do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
        get '/:id/invoice', to: 'invoices#show'
      end

      resources :merchants, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end

