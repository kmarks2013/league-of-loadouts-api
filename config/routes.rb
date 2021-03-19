Rails.application.routes.draw do
  defaults format: :json do 
    resources :stats
    resources :champion_roles
    resources :roles
    resources :loadout_items,  only: [:index, :show, :create,:destroy]
    resources :items
    resources :loadouts
    resources :champions
    resources :users

    get '/persist', to: 'auth#persist'
    post '/login', to: 'auth#login'
  end
  
end
