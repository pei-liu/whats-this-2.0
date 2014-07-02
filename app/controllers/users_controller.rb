class UsersController < ApplicationController
  def create
    # puts '*' * 100
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      render nothing: true
    else
      flash.now.alert = "Error"
      render nothing: true
    end
  end

  def login
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
