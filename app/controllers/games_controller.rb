class GamesController < ApplicationController
  def index
    @user = User.new
    @games = Game.where(is_complete: false)
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

  def completed
    @completed_games = Game.where(is_complete: true)
  end
end
