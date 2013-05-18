class AddInformedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :informed, :text
  end
end
