class RemoveCompletedFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completed, :boolean
  end
end
