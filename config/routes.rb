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

  namespace :api do
    get '/games' => 'games#index'
    get '/users/current' => 'users#show_current'
  end
end
