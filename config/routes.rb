Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:show, :index]
  resources :events, only: [:index]
  resources :branches, only: [:index]
  resources :branch_events, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
