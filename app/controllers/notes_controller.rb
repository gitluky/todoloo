class NotesController < ApplicationController

  def create
    @task = Task.find_by(id: params[:task_id])
    @note = @task.notes.build(note_params)
    @note.user = current_user
    @note.save
    redirect_to task_path(@task)
  end

  def edit

  end

  def destroy

  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
