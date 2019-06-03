class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def show
    if @group.users.exclude?(current_user)
      redirect_to user_path(current_user)
    end
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

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :image )
  end

end
