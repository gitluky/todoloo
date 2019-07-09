class SessionsController < ApplicationController

  skip_before_action :redirect_if_not_logged_in

  def new

  end

  def create
    if oauth_hash = request.env['omniauth.auth']
      user = User.find_or_create_by_oauth(oauth_hash)
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.find_by(email: params[:email])
      if user.try(:authenticate, params[:password])
        session[:user_id] = user.id
        redirect_to root_path
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
