class GamesController < ApplicationController
  def index
    games = Game.where(is_complete: false)
    @first_game_set = games.shift(3)
    @remaining_game_sets = []
    while games.any?
      @remaining_game_sets << games.shift(3)
    end
  end

  def create
    if user_logged_in?
      game = Game.create(user_id: current_user)
      Round.create( game_id: game.id,
                    user_id: current_user,
                    content: params['round']['content'],
                    content_type: params['round']['content_type'])
    end
    redirect_to root_path
  end

  def new
    if user_logged_in?
      session.delete(:game_id)
    else
      flash[:error] = "Please log in to create a new game!"
      redirect_to root_path
    end
  end

  def completed
    @completed_games = Game.where(is_complete: true)
  end
end
