class AddIndex < ActiveRecord::Migration
  def up
    add_index :tasks, :ancestry
  end

  def down
    remove_index :tasks, :ancestry
  end
end
