class ChangeGroupsUsersToMemberships < ActiveRecord::Migration[5.2]
  def change
    rename_table :groups_users, :memberships
  end
end
