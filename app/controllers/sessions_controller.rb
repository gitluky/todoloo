class SessionsController < ApplicationController

  def new

  end

  def create
    if oauth_hash = request.env['omniauth.auth']
      user = User.find_or_create_by_oauth(oauth_hash)
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      user = User.find_by(email: params[:email])
      if user.try(:authenticate, params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to login_path
      end
    end

  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end

end
