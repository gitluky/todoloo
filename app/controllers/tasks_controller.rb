class TasksController < ApplicationController

  def create
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.build(task_params)
    @task.created_by = current_user
    @task.save
    redirect_to group_path(@group)
  end

  def show
    @task = Task.find_by(id: params[:id])
    @notes = @task.notes.where.not(id: nil)
    @note = @task.notes.build
  end

  def edit
    @group = Note.find_by(id: params[:group_id])
    @task = Task.find_by(id: params[:id])
  end

  def update
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.find_by(id: params[:id])
    @task.update(task_params)
    redirect_to group_path(@group)
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @group = @task.group
    @task.destroy
    redirect_to group_path(@group)
  end

  def assign
    @task = Task.find_by(id: params[:id])
    @task.assigned_to = current_user
    @task.status = "Assigned"
    @task.save
    redirect_to group_path(@task.group)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :assigned_to_id)
  end

end
