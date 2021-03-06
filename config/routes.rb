Rails.application.routes.draw do
  resources :posts
  resources :users, :except => [:index, :destroy]

  root 'landing#index'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: 'logout'
  get '/about' => 'about#index'
end
