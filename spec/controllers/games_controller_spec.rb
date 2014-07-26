require 'spec_helper'

describe GamesController do
  let(:user) { create :user }
  let(:game) { create :game }
  # let(:round) { create :round_description}
  let(:completed_game) { create :completed_game }

  describe "GET #index" do
    # it 'assigns all incomplete games to @games' do
    #   get :index
    #   expect(assigns(:games)).to eq [game]
    # end
    it 'assigns 3 incomplete games to @first_game_set'
    it 'assigns rest of incomplete games to @remaining_game_sets'
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

  describe "GET #new" do
    context "user is logged in" do
      before(:each) do
        session[:user_id] = user.id
        session[:game_id] = 1
      end

      it "deletes the session[:game_id]" do
        get :new
        expect(session[:game_id]).to eq nil
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "user is NOT logged in" do
      it "redirects to the root path" do
        get :new
        expect(session).to redirect_to root_path
      end
    end
  end

  describe 'GET #completed' do
    # this test should be passing...
    it 'assigns all completed games to @completed_games' #do
      # get :completed
      # expect(assigns(:completed_games)).to eq [completed_game]
    # end
  end
end
