Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :brands, only: [:index, :show]
      resources :cashbacks, only: [:index, :show]
      resources :categories, only: [:index, :show]
      resources :companies, only: [:index, :show]
      resources :products, only: [:index, :show]
      resources :stores, only: [:index, :show]
    end
  end
end
