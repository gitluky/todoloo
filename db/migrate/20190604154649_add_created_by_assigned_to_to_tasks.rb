class AddCreatedByAssignedToToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :created_by_id, :integer
    add_column :tasks, :assigned_to_id, :integer
  end
end
