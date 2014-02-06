class Comment < ActiveRecord::Base
  attr_accessible :task_id, :text, :user_id
  belongs_to :user
  belongs_to :task
  has_paper_trail

  validates_presence_of :task_id, :user_id, :text

  after_create :email_assignees

  attr_reader :private

  def private?
    self.task.private? ? true : false
  end

  def email_assignees
    recipients = self.task.users
    author_email = self.task.author.email
    emails = []
    emails << author_email
    recipients.each {|u| emails << u.email}
    emails.delete(self.user.email) if emails.include?(self.user.email)
    UserMailer.delay.comment_assignees_email(self.id, emails) if emails.count > 0
  end

  def self.rss
    visible = []
    comments = Comment.order('created_at DESC').limit(25)
    comments.each {|c| visible << c unless c.private? }
    visible
  end
end
