Rails.application.routes.draw do
  get 'pages/contact'
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:show, :index, :new, :create] do
    get 'final', to: 'trips#final', as: :final
    resources :events, only: [:create, :edit, :update, :destroy]
  end
  resources :events, only: [:index] do
    member do
      patch :switch_master
      post :add_branch_relationship
    end
  end
end
