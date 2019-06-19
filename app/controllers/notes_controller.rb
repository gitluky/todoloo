class NotesController < ApplicationController

  def create
    @task = Task.find_by(id: params[:task_id])
    @note = @task.notes.build(note_params)
    @note.user = current_user
    @note.save
    redirect_to task_path(@task)
  end

  def edit
    @note = Note.find_by(id: params[:id])
    @task = Task.find_by(id: params[:task_id])
  end

  def update
    @task = Task.find_by(id: params[:task_id])
    @note = Note.find_by(id: params[:id])
    binding.pry
    @note.update(note_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find_by(id: params[:task_id])
    @note = @task.notes.find_by(id: params[:id])
    @note.destroy
    redirect_to task_path(@task)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
