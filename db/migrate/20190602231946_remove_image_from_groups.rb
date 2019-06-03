class RemoveImageFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :image, :string
  end
end
