class AddNestedSet < ActiveRecord::Migration
  def up
    add_column :tasks, :lft, :integer
    add_column :tasks, :rgt, :integer
    add_column :tasks, :parent_id, :integer
    add_column :tasks, :depth, :integer
  end

  def down
  end
end
