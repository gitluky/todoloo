class AnnouncementsController < ApplicationController

  before_action :set_parent_group, only: [:index, :new, :create, :edit]
  before_action :set_nested_announcement, only: [:edit, :update, :destroy]

  def index
    @group = Group.find_by(params[:group_id])
    @announcements = @group.announcements
  end

  def new
    @group = Group.find_by(params[:group_id])
    @announcement = Group.announcements.build
  end

  def create
    @group = Group.find_by(params[:group_id])
    @announcement = @group.announcements.create(announcements_params)
  end

  def edit
    
  end

  def update

  end

  def destroy
    @announcement.destroy
  end

  private

  def set_parent_group
    @group = Group.find_by(params[:group_id])
  end

  def set_nested_announcement
    @announcement = @group.announcements.find_by(id: params[:id])
  end

end
