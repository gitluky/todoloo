class ApplicationController < ActionController::Base
  include SessionsHelper
  include GroupsHelper

  def index
    if logged_in?
      @user = current_user
      @invitations = @user.received_invitations
      @groups = @user.groups
      @announcements = @groups.collect {|group| group.announcements.last }.delete_if(&:blank?)
      @tasks = @user.assigned_tasks
    end
  end

end
