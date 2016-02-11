class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :current_user
  after_filter :flash_to_http_header
  
  private

  def current_user=(user)
    session[:current_user_id] = User === user ? user.id : nil
    user
  end

  def current_user
    if id = session[:current_user_id]
      begin
        @current_user = User.find(id)  
      rescue ActiveRecord::RecordNotFound => e
        self.current_user = nil
      end
    end 
  end

  def signed_in?
    !!current_user
  end

  def authenticate_user
    redirect_to '/', flash: {error: "You must be logged in!"} unless current_user
  end

  def flash_to_http_header
    return unless request.xhr?
    return if flash.empty?
    response.headers['X-FlashMessages'] = flash.to_hash.to_json
    flash.discard
  end

end