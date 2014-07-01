require 'spec_helper'

describe UsersController do

  describe "POST create" do
    context "with VALID attributes" do
      it "creates a new user in the database"
      it "saves the user id to session[:user_id]"
    end

    context "with INVALID attributes" do
      it "does not create a new user in the database"
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
    it "clears the session"
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
