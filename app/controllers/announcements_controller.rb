class AnnouncementsController < ApplicationController

  before_action :set_parent_group, only: [:index, :new, :create, :edit, :update]
  before_action :set_nested_announcement, only: [:edit, :update, :destroy]

  def index
    @group = Group.find_by(params[:group_id])
    @announcements = @group.announcements
  end

  def new
    @group = Group.find_by(params[:group_id])
    @announcement = @group.announcements.build
  end

  def create
    @group = Group.find_by(params[:group_id])
    @announcement = @group.announcements.build(announcement_params)
    @announcement.user = current_user
    @announcement.save
    redirect_to group_path(@group)
  end

  def edit

  end

  def update
    @annoucemennt.update(announcement_params)
    redirect_to group_path(@group)
  end

  def destroy
    @announcement.destroy
    redirect_to group_path(@group)
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end

  def set_parent_group
    @group = Group.find_by(params[:group_id])
  end

  def set_nested_announcement
    @announcement = @group.announcements.find_by(id: params[:id])
  end

end
