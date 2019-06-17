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

  def show
    @task = Task.find_by(id: params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def assign
    @task = Task.find_by(id: params[:id])
    @task.assigned_to = current_user
    @task.save
    redirect_to group_path(@task.group)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :assigned_to_id)
  end

end
