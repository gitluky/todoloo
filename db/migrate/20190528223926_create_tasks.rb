class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :group_id
      t.integer :user_id
      t.boolean :completed

      t.timestamps
    end
  end
end
