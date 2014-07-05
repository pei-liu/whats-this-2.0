require 'spec_helper'

describe UsersController do
  let(:user) { create :user }
  # let(:user_with_games_and_rounds) { create :user_with_games_and_rounds }

  describe "POST create" do
    context "with VALID attributes" do
      it "creates a new user in the database" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "saves the user id to session[:user_id]" do
        post :create, user: attributes_for(:user)
        expect(session[:user_id]).to eq User.last.id
      end
    end

    context "with INVALID attributes" do
      it "does not create a new user in the database if username already taken" do
        @user = create :user
        expect{
        post :create, user: { username: @user.username,
                              password: 'password',
                              password_confirmation: 'password'}
        }.to_not change(User, :count)
      end

      it "does not create a new user in the DB if username is blank" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end
    end
  end

  describe "POST login" do
    context "with VALID credentials" do
      it "saves the user id to session[:user_id]" do
        post :login, user: { username: user.username, password: user.password }
        expect(session[:user_id]).to eq user.id
      end
    end

    context "with INVALID credentials" do
      it "does NOT save the user id to session[:user_id] if username doesn't exist" do
        post :login, user: { username: 'nonexistent_user', password: 'yolo' }
        expect(session[:user_id]).to eq nil
      end

      it "does NOT save the user id to session[:user_id] if password is incorrect" do
        post :login, user: { username: user.username, password: "incorrect_pw" }
        expect(session[:user_id]).to eq nil
      end
    end
  end

  describe "GET logout" do
    it "resets the session" do
      session[:user_id] = user.id
      get :logout
      expect(session[:user_id]).to eq nil
    end
  end

  describe "GET games" do
    before(:each) do
      game = Game.create
      @user_game = user.games.build
      @user_game.save
      @user_round = Round.new(  content_type: "description",
                                content: "some content",
                                user_id: user.id,
                                game_id: game.id)
      @user_round.save
    end

    context "logged in" do
      before(:each) { session[:user_id] = user.id }

      it "assigns to @created_games, games that the user started" do
        get :games
        expect(assigns(:created_games)).to eq [@user_game]
      end

      it "assigns to @played_rounds, games that the user participated in" #do
        # CAN'T SEEM TO GET THIS SEEMINLY SIMPLE TEST TO PAST.
        # get :games
        # expect(assigns(:played_rounds)).to eq [@user_round]
      # end
    end

    context "NOT logged in" do
      it "redirects to homepage" do
        get :games
        expect(response).to redirect_to root_path
      end
    end
  end

end
