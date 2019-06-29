class ApplicationController < ActionController::Base
  include SessionsHelper
  include GroupsHelper
  include TasksHelper
  
  def index
    if logged_in?
      @user = current_user
      @invitations = @user.received_invitations
      @groups = @user.groups
    end
  end

end
