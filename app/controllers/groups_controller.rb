class GroupsController < ApplicationController

  before_action :validate_logged_in, :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.has_member(current_user)
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.create(group_params)
    @group.last_edited_by = current_user
    @group.announcements.create(title: 'Welcome!', content: 'Welcome to your new group! You can now start inviting members and creating tasks.')
    @group.save
    redirect_to groups_path
  end

  def show
    if @group.users.exclude?(current_user)
      redirect_to user_path(current_user)
    end
    @invitations = @group.invitations
    @announcements = @group.announcements
    @available_tasks = @group.tasks.where(assigned_to_id: nil).where.not(status: 'Completed')
    @assigned_tasks = @group.tasks.where.not(assigned_to_id: nil).where.not(status: 'Completed')
    @completed_tasks = @group.tasks.where(status: 'Completed')
    @task = @group.tasks.build
    @members = User.members_of_group(@group)
  end

  def edit

  end

  def update
    @group.last_edited_by = current_user
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :image )
  end

end
