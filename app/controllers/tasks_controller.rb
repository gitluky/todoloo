class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :destroy, :volunteer, :drop_task, :complete, :incomplete, :admin_or_creator]
  before_action :admin_or_creator, only: [:edit, :update, :destroy]
  before_action
  def create
    @group = Group.find_by(id: params[:group_id])
    @task = @group.tasks.build(task_params)
    @task.created_by = current_user
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def completed_tasks
    @group = Group.find_by(id: params[:group_id])
    @completed_tasks = @group.completed_tasks
    @members = @group.users
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

  def volunteer
    @task.assigned_to = current_user
    @task.status = "Assigned"
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def drop_task
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

  def admin_or_creator
    @group = @task.group
    if !current_user.is_admin?(@group) && current_user != @task.created_by
      redirect_to group_path(@group)
    end
  end


end
