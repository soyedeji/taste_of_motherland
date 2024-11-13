Rails.application.routes.draw do
  get "cart/add_to_cart"
  get "cart/show"
  get "menus/show"

  root "home#index"
  get "categories/index"
  get "categories/show"
  devise_for :admins

  namespace :admin do
    root to: "dashboard#index"
    resources :menus, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :categories, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end

  # Define routes for menus to show individual product details
  resources :menus, only: [:show]

  resources :menus, only: [:index, :show]
  post 'add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
  get 'cart', to: 'cart#show', as: 'cart'


end
