class TasksController < ApplicationController

  def new
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.build
  end

  def create
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.build(task_params)
    @task.created_by = current_user
    @task.save
    redirect_to group_path(@group)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :assigned_to_id)
  end

end
