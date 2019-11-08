Rails.application.routes.draw do
  resources :champion_roles
  resources :roles
  resources :loadout_items,  only: [:index, :show, :create]
  resources :items
  resources :loadouts
  resources :champions
  resources :users

  delete '/loadout_items', to: 'loadout_items#destroy'

  get '/persist', to: 'auth#persist'
  post '/login', to: 'auth#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
