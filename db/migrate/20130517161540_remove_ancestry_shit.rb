class RemoveAncestryShit < ActiveRecord::Migration
  def up
    remove_index :tasks, :ancestry
    remove_column :tasks, :ancestry
  end

  def down

  end
end
