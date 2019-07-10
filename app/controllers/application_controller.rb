class ApplicationController < ActionController::Base
  include SessionsHelper
  include GroupsHelper
  include TasksHelper
  include AnnouncementsHelper

  before_action :redirect_if_not_logged_in
  skip_before_action :redirect_if_not_logged_in, only: [:index]

  def index
    if logged_in?
      @user = current_user
      @invitations = @user.received_invitations
      @groups = @user.groups
    end
  end

end

private

def redirect_if_not_logged_in
  if !logged_in?
    redirect_to login_path
  end
end

def validate_user_group_membership
  if @group.users.exclude?(current_user)
    redirect_to root_path
  end
end
