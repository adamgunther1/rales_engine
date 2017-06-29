Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/revenue', to: 'revenue#index'
        get '/most_revenue', to: 'most_revenue#index'
        # get '/:id/revenue', to: 'revenue#show'       
        get '/:id/customers_with_pending_invoices', to: 'customers_with_pending_invoices#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end
      namespace :items do
        get '/most_revenue', to: 'most_revenue#index'
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

