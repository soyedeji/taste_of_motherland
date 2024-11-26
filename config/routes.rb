Rails.application.routes.draw do
  devise_for :customers
  # Cart routes
  resource :cart, only: [ :show ], controller: "cart" do
    post :add_to_cart, path: "add/:menu_id"
    patch :update_quantity
    delete :remove_item
  end

  # Checkout routes
  resource :checkout, only: [ :new, :create ], controller: "checkout"
  get "order/:id", to: "checkout#show", as: "order" # Show order summary for a specific order

  # Menu routes
  resources :menus, only: [ :show ]

  # Categories and home routes
  root "home#index"
  get "categories/index"
  get "categories/show"

  # Admin routes
  devise_for :admins
  namespace :admin do
    root to: "dashboard#index"
    resources :menus, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :categories, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end
end
