Rails.application.routes.draw do
  resources :images
  resources :posts

  root 'landing#index'
end
