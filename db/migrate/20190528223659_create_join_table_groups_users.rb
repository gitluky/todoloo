class CreateJoinTableGroupsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :admin,  default:false
      
      t.timestamps
    end
  end
end
