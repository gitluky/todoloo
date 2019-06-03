class AddAcceptToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :accept, :boolean
  end
end
