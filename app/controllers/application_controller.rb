class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_logged_in?

  def current_user
    @current_user ||= session[:user_id]
  end

  def user_logged_in?
    current_user != nil
  end

end
