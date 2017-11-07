Rails.application.routes.draw do
  root 'pages#welcome'
  resources :users, :games
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/user_games' => 'user_games#create'
  get '/signup' => 'users#new'
  match '/auth/:provider/callback', to: 'users#update', via: :all

  namespace :api do
    get '/games' => 'games#index'
  end
end
