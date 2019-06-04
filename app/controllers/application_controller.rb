class ApplicationController < ActionController::Base
  include SessionsHelper

  def index
    if logged_in?
      @user = current_user
      @invitations = @user.invitations
      @groups = @user.groups
      @announcements = @groups.collect {|group| group.announcements.last }.delete_if(&:blank?)
      @tasks = @user.tasks
    end
  end

end
