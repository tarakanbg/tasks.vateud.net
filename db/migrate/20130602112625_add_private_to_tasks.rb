class AddPrivateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :private, :boolean, :default => false
  end
end
