class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :destroy, :assign, :unassign, :complete, :incomplete]

  def create
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.build(task_params)
    @task.created_by = current_user
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def show
    @notes = @task.notes.where.not(id: nil)
    @group = @task.group
    @note = @task.notes.build
  end

  def edit
    @group = Note.find_by(id: params[:group_id])

  end

  def update
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.find_by(id: params[:id])
    @task.update(task_params)
    if !!@task.assigned_to_id
      @task.status = 'Assigned'
      @task.save
    end
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def destroy
    @group = @task.group
    @task.destroy
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def assign
    @task.assigned_to = current_user
    @task.status = "Assigned"
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def unassign
    @task.assigned_to = nil
    @task.status = "Available"
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def complete
    @task.status = 'Completed'
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def incomplete
    @task.status = 'Assigned'
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :assigned_to_id)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

end
