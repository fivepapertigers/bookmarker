class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :current_user
  
  private

  def current_user=(user)
    session[:current_user_id] = User === user ? user.id : nil
    user
  end

  def current_user
    if id = session[:current_user_id]
      @current_user = User.find(id)
    end 
  end

  def signed_in?
    !!current_user
  end

  def authenticate_user
    redirect_to '/', flash: {error: "You must be logged in!"} unless current_user
  end

end