Rails.application.routes.draw do
  devise_for :users
  resources :users , only: [:index, :show, :edit, :update]
  resources :books , only: [:new, :index, :create, :show, :edit, :update, :destroy]
  get "home/about" => "homes#about", as: "about"
  root to: "homes#top"
end
