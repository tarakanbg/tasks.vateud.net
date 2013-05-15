class Task < ActiveRecord::Base
  attr_accessible :active, :author_id, :description, :due_date, :name, :status_id

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :status
end
