WhatsThis::Application.routes.draw do

  root 'games#index' # Home page.  Has all in progress games.

  post '/games' to: 'games#create' # Create a new game in database
  get '/games/completed' to: 'games#completed' # View a list of all completed games

  get '/users/games' to: 'users#games' # User can only see games they've been in, hence no id
  post '/users' to: 'users#create' # Sign up.  Use ajax to post to controller.
  post '/users/login' to: 'users#login' # User login.  Ajax post creates new session.
  get '/users/logout' to: 'users#logout'

  post '/rounds' to: 'rounds#create' # Creates a new round and adds it to a game

end
