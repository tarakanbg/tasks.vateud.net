class Comment < ActiveRecord::Base
  attr_accessible :task_id, :text, :user_id
  belongs_to :user
  belongs_to :task
  has_paper_trail

  validates_presence_of :task_id, :user_id, :text

  attr_reader :private

  def private?
    self.task.private? ? true : false    
  end

  def self.rss
    visible = []
    comments = Comment.order('created_at DESC').limit(25)
    comments.each {|c| visible << c unless c.private? }
    visible
  end
end
