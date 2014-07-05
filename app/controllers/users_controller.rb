class UsersController < ApplicationController
  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Account successfully created. Welcome #{new_user.username}!"
      redirect_to users_games_path
    else
      flash[:error] = "Signup Error"
      redirect_to root_path
    end
  end

  def login
    if user = User.find_by(username: user_params[:username])
      if user.authenticate(user_params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome back #{user.username}!"
        redirect_to users_games_path
      else
        flash[:error] = "Invalid password"
        redirect_to root_path
      end
    else
        flash[:error] = "Invalid username"
        redirect_to root_path
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def games
    if user_logged_in?
      @user = User.find(session[:user_id])
      @created_games = @user.games
      @played_rounds = @user.rounds
      render 'games'
    else
      redirect_to root_path
    end
  end



  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
