require 'spec_helper'

describe UsersController do
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
      it "saves the user id to sesison[:user_id]"
    end

    context "with INVALID credentials" do
      it "does NOT save the user id to sesison[:user_id]"
    end
  end

  describe "GET logout" do
    it "resets the session"
  end

  describe "GET games" do
    context "logged in" do
      it "assigns to @created_games, games that the user started"
      it "assigns to @played_games, games that the user participated in"
    end

    context "NOT logged in" do
      it "redirects to homepage"
    end
  end

end
