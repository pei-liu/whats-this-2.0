require 'spec_helper'

describe GamesController do
  let(:user) { create :user }
  let(:game) { create :game }
  # let(:round) { create :round_description}
  let(:completed_game) { create :completed_game }

  describe "GET #index" do
    it 'assigns all incomplete games to @games' do
      get :index
      expect(assigns(:games)).to eq [game]
    end
  end

  describe "POST #create" do
    it 'creates a new game in the database' do
      session[:user_id] = user.id
      expect{
        post :create, round: attributes_for(:round_description)
      }.to change(Game, :count).by(1)
    end

    it 'creates a new round for the newly created game' do
      session[:user_id] = user.id
      expect{
        post :create, round: attributes_for(:round_description)
      }.to change(Round, :count).by(1)
    end

    it 'new game has only one round' do
      session[:user_id] = user.id
      post :create, round: attributes_for(:round_description)
      expect(Game.last.rounds.count).to eq(1)
    end
  end
end
