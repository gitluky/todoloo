class GroupsController < ApplicationController

  before_action :validate_logged_in, :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.create(group_params)
    if @group.errors.empty?
      @group.last_edited_by = current_user
      @group.announcements.create(title: 'Welcome!', content: 'Welcome to your new group! You can now start inviting members and creating tasks.')
      current_user.make_admin_membership(@group)
      @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    if @group.users.exclude?(current_user)
      redirect_to root_path
    end
    @invitations = @group.invitations
    @announcements = @group.announcements
    @available_tasks = @group.tasks.where(assigned_to_id: nil).where.not(status: 'Completed')
    @assigned_tasks = @group.tasks.where.not(assigned_to_id: nil).where.not(status: 'Completed')
    @completed_tasks = @group.tasks.where(status: 'Completed')
    @task = @group.tasks.build
    @members = @group.users
    @admins = @group.admins
    @non_admins = @group.non_admins

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
