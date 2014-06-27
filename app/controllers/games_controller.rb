class GamesController < ApplicationController
  def index
    @games = Game.where(is_complete: false)
  end

  def create
  end

  def completed
  end
end
