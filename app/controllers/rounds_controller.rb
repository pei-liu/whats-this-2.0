class RoundsController < ApplicationController
  def create_drawing
    svg = params["svg"]
    if session[:game_id] #This is an addition to an existing game
    else #This is the first drawing of a new game
      game = Game.create(user_id: current_user)
      round = Round.create( game_id: game.id, 
                            user_id: current_user,
                            content: svg,
                            content_type: "drawing")
    end
    # render nothing: true
    redirect_to root_path
  end

  def create_description
  end
end
