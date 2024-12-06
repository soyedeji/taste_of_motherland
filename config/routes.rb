Rails.application.routes.draw do
  # Devise routes for Customers and Admins
  devise_for :customers
  devise_for :admins

  # Cart routes
  resource :cart, only: [ :show ], controller: "cart" do
    post :add_to_cart, path: "add/:menu_id"
    patch :update_quantity
    delete :remove_item
  end

  # Checkout routes
  resources :checkout, only: [ :new, :create ]
  get "order/:id", to: "checkout#show", as: "order"

  # Menu routes
  resources :menus, only: [ :show ]

  # Categories and home routes
  root "home#index"
  get "categories/index"
  get "categories/show"

  # Admin namespace
  namespace :admin do
    root to: "dashboard#index"
    resources :menus, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :categories, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end

  # Order routes
  resources :orders, only: [ :index, :show ]

  # Payment routes
  resources :payments, only: [ :create ] do
    member do
      get :success
      get :cancel
    end
  end
end
