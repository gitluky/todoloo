class SessionsController < ApplicationController

  def new

  end

  def create
    if oauth_hash = request.env['omniauth.auth']
      user = User.find_or_create_by_oauth(oauth_hash)
      log_in(user)
    else
      user = User.find_by(email: params[:email])
      if user.try(:authenticate, params[:password])
        log_in(user)
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
