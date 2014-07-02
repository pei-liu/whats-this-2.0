class UsersController < ApplicationController
  def create
    # puts '*' * 100
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
    else
      flash.now.alert = "Signup Error"
    end
    render nothing: true
  end

  def login
    if user = User.find_by(username: user_params[:username])
      if user.authenticate(user_params[:password])
        session[:user_id] = user.id
      else
        flash.now.alert = "Invalid password"
      end
    else
      flash.now.alert = "Invalid username"
    end
    render nothing: true
  end

  def logout
  end

  def games
  end



  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
