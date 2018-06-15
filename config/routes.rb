Rails.application.routes.draw do
  get "/signin" => 'sessions#new'
  post "/sessions/create" => "sessions#create"
  delete "/signout" => "sessions#destroy"
  resources :attractions, only: [:index, :new, :create, :show]
  resources :users, only: [:new, :create, :show]
  root "static#home"
end
