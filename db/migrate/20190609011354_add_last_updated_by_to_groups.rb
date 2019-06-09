class AddLastUpdatedByToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :last_edited_by_id, :integer
  end
end
