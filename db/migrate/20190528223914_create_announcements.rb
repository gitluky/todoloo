class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :content
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
