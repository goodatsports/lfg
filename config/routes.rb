Rails.application.routes.draw do
  root 'pages#welcome'
  resources :users, :games
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/user_games' => 'user_games#create'
  get '/signup' => 'users#new'
  match '/auth/:provider/callback', to: 'users#update', via: :all

  get '/users/:id/user_games' => 'user_games#index'
  get '/users/:id/user_games/new' => 'user_games#new'
  delete '/user_games/:id' => 'user_games#destroy'

  namespace :api do
    get '/games' => 'games#index'
    post '/games' => 'games#create'
    get '/users/current' => 'users#show_current'
    get '/users/current/steam' => 'users#steam_library'
  end
end
