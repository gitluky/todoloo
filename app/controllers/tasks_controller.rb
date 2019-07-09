class TasksController < ApplicationController


  before_action :set_task, only: [:show, :edit, :destroy, :volunteer, :drop_task, :complete, :incomplete, :edit_privileges, :set_group]
  before_action :set_group
  before_action :validate_user_group_membership
  before_action :edit_privileges, only: [:edit, :update, :destroy]

  def create

    @task = @group.tasks.build(task_params)
    @task.created_by = current_user
    @task.save
    redirect_to group_path(@task.group, anchor: 'task_section')
  end

  def completed_tasks

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

    @task = @group.tasks.find_by(id: params[:id])
    @task.update(task_params)
    if !!@task.assigned_to_id
      @task.status = 'Assigned'
      @task.save
    end
    redirect_to group_path(@group, anchor: 'task_section')
  end

  def destroy

    @task.destroy
    redirect_to group_path(@group, anchor: 'task_section')
  end

  def volunteer
    @task.assigned_to = current_user
    @task.status = "Assigned"
    @task.save
    redirect_to group_path(@group, anchor: 'task_section')
  end

  def drop_task
    @task.assigned_to = nil
    @task.status = "Available"
    @task.save
    redirect_to group_path(@group, anchor: 'task_section')
  end

  def complete
    @task.status = 'Completed'
    @task.save
    redirect_to group_path(@group, anchor: 'task_section')
  end

  def incomplete
    @task.status = 'Assigned'
    @task.save
    redirect_to group_path(@group, anchor: 'task_section')
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :assigned_to_id)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

  def set_group
    if params[:group_id]
      @group = Group.find_by(id: params[:group_id])
    else
      @group = @task.group
    end
  end

  def edit_privileges
    if !current_user.is_admin?(@group) && current_user != @task.created_by
      redirect_to group_path(@group)
    end
  end


end
