Rails.application.routes.draw do
  devise_for :admins

  namespace :admin do
    root to: "dashboard#index"
    resources :menus, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  root "home#index"
end
