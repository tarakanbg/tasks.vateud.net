class AddStaffAndPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :staff, :boolean, :default => false
    add_column :users, :position, :string
  end
end
