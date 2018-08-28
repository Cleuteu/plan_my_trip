Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:show, :index] do
    resources :branches, only: [:create]
  end

  resources :events, only: [:index]

  resources :branches, only: [:index] do
    resources :events, only: [:create]
  end

  resources :branch_events, only: [:index]
end
