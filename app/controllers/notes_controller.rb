class NotesController < ApplicationController

  before_action :set_task
  before_action :set_note, only: [:edit, :update, :destroy, :edit_privileges]
  before_action :edit_privileges, only: [:edit, :update, :destroy]

  def create
    @note = @task.notes.build(note_params)
    @note.user = current_user
    if @note.save
      redirect_to task_path(@task), flash: { message: 'Note has been added.'}
    else
      @group = @task.group
      @notes = @task.notes
      render 'tasks/show'
    end
  end

  def edit

  end

  def update
    @note.update(note_params)
    redirect_to task_path(@task), flash: { message: 'Task has been successfully updated.' }
  end

  def destroy
    @note.destroy
    redirect_to task_path(@task), flash: { message: 'Note has been deleted.' }
  end

  private

  def set_task
    @task = Task.find_by(id: params[:task_id])
  end

  def set_note
    @note = Note.find_by(id: params[:id])
  end

  def note_params
    params.require(:note).permit(:content)
  end

  def edit_privileges
    @group = @task.group
    if !current_user.is_admin?(@group) && current_user != @note.user
      redirect_to task_path(@task), flash: { message: 'You do not have the rights to perform action.' }
    end
  end
end
