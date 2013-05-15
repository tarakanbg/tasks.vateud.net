class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.integer :priority
      t.string :css

      t.timestamps
    end
  end
end
