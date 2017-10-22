Rails.application.routes.draw do
  root 'pages#welcome'
  resources :users, :games
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/user_games' => 'user_games#create'
  get '/signup' => 'users#new'
end
