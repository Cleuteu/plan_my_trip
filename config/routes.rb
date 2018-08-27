Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:show]
  resources :events, only: [:index]
  resources :branches, only: [:index]
  resources :branch_events, only: [:index]
end
