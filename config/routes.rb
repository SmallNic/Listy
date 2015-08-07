Rails.application.routes.draw do

  resources :lists do
    resources :items
  end

  resources :items, only: [:show, :update]

  root 'lists#index'
end
