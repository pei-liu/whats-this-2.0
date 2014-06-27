require 'spec_helper'

describe GamesController do
  let(:user) { create :user }
  let(:game) { create :game }
  let(:completed_game) { create :completed_game }

  describe "GET #index" do
    it 'assigns all incomplete games to @games' do
      get :index
      expect(assigns(:games)).to eq [game]
    end
  end
end
