Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:show, :index, :new, :create] do
    resources :events, only: [:create, :edit, :update, :destroy]
  end

  resources :events, only: [:index]

  resources :branches, only: [:index] do
    resources :events, only: [:create, :edit, :update, :destroy]
  end

  resources :branch_events, only: [:index]
end
