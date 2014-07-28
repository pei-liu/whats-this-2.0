class RoundsController < ApplicationController

  def new #this needs to be refactored
    if user_logged_in?
      @game = Game.find(params[:game_id])
      if @game.rounds.last.user_id == current_user
        flash[:error] = "Dude, you can't play your own contribution. Lame."
        redirect_to root_path
      else
        @last_round = @game.rounds.last
        session[:game_id] = @game.id
        if @last_round.content_type == "drawing"
          render :new_description_to_game
        else
          render :new_drawing_to_game
        end
      end
    else
      flash[:error] = "Please sign in or create an account to play."
      redirect_to root_path
    end
  end

  def create_drawing
    svg = params["svg"]
    if session[:game_id] #This is an addition to an existing game
      game = Game.find(session[:game_id])
      Round.create( game_id: session[:game_id],
                    user_id: current_user,
                    content: svg,
                    content_type: "drawing")
      game.check_finished
      session.delete(:game_id)
    else #This is the first drawing of a new game
      game = Game.create(user_id: current_user)
      round = Round.create( game_id: game.id,
                            user_id: current_user,
                            content: svg,
                            content_type: "drawing")
    end
    redirect_to root_path
  end

  def create_description
    description = params["description"]
    if session[:game_id] #This is an addition to an existing game
      game = Game.find(session[:game_id])
      Round.create( game_id: session[:game_id],
                    user_id: current_user,
                    content: description,
                    content_type: "description")
      game.check_finished
      session.delete(:game_id)

    else #This is the first drawing of a new game
      game = Game.create(user_id: current_user)
      Round.create( game_id: game.id,
                    user_id: current_user,
                    content: description,
                    content_type: "description")
    end
    redirect_to root_path
  end
end
