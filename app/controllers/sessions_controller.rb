class SessionsController < ApplicationController
  
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    @user.save! unless @user.id
    self.current_user = @user
    redirect_to '/'
  end

  def destroy
    self.current_user = nil
    redirect_to '/'
  end

  def failure
    logger.error params[:message]
    flash[:notice] = params[:message]
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
