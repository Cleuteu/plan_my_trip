Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:show, :index] do
    resources :branches, only: [:create]
  end

  resources :events, only: [:index]
  resources :branches, only: [:index, :edit, :update]
  resources :branch_events, only: [:index]
end
