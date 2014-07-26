WhatsThis::Application.routes.draw do

  root 'games#index' # Home page.  Has all in progress games.

  ### GAMES
  post '/games' => 'games#create' # Create a new game in database
  get '/games/completed' => 'games#completed' # View a list of all completed games
  get '/games/new' => 'games#new'

  ### USERS
  get '/users/games' => 'users#games' # User can only see games they've been in, hence no id
  post '/users' => 'users#create' # Sign up.  Use ajax to post to controller.
  post '/users/login' => 'users#login' # User login.  Ajax post creates new session.
  get '/users/logout' => 'users#logout'

  ### ROUNDS
  get '/games/:game_id/rounds/new' => 'rounds#new', as: :rounds_new
  post '/rounds/create_drawing' => 'rounds#create_drawing'
  post '/rounds/create_description' => 'rounds#create_description'

  match '/get_completed_games', to: 'games#get_completed_games', via: 'get'

end
