class RemoveActiveFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :active
  end

  def down
  end
end
