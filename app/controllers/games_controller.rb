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
  end

  def get_completed_games
    respond_to do |format|
      format.html { render :json => get_completed_games_json }
      format.json { render :json => get_completed_games_json }
    end
  end

  private
  def get_completed_games_json
    @completed_games = Game.where(is_complete: true)
    front_end_games_model = @completed_games.each_with_object [] do |game, g_model|
      round_model = game.rounds.each_with_object [] do |round, r_model|
        r_model << {  id:           round.id,
                      player_id:    round.user_id,
                      content:      round.prepared_content,
                      content_type: round.content_type }
      end

      g_model << {  id:         game.id,
                    creator_id: game.user_id,
                    rounds:     round_model }
    end

    # @game_model_data_json = front_end_games_model.to_json.html_safe
    front_end_games_model
  end
end


