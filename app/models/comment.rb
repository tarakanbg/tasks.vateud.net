class Comment < ActiveRecord::Base
  attr_accessible :task_id, :text, :user_id
  belongs_to :user
  belongs_to :task

  validates_presence_of :task_id, :user_id, :text
end
