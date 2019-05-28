class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.integer :group_id
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
