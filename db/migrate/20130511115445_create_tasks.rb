class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :author_id
      t.string :name
      t.text :description
      t.integer :priority_id
      t.datetime :due_date
      t.integer :status_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
