class GroupsController < ApplicationController

  before_action :validate_logged_in, :set_group, only: [:show, :edit, :update, :destroy]
  before_action :validate_current_user, only: [:index]

  def index
    @groups = Group.has_member(params[:user_id])
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @group = @user.groups.build
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @group = @user.groups.create(group_params)
    redirect_to user_groups_path
  end

  def show
    if @group.users.exclude?(current_user)
      redirect_to user_path(current_user)
    end
    @invitations = @group.invitations
  end

  def edit

  end

  def update
    @group.update(group_params)
  end

  def destroy
    @group.delete
    redirect_to user_path(current_user)
  end

  private

  def validate_logged_in
    if !logged_in?
      redirect_to login_path
    end
  end

  def validate_current_user
    if current_user.id != params[:user_id].to_i
      redirect_to user_groups_url(current_user)
    end
  end

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :image )
  end

end
