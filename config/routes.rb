Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/revenue', to: 'revenue#index'
        get '/:id/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
