class Task < ActiveRecord::Base
  attr_accessible :author_id, :description, :due_date, :name, :status_id, :user_ids,
                  :parent_id, :lft, :rgt, :informed

  serialize :informed                
  attr_reader :assignees

  acts_as_nested_set

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :status
  has_and_belongs_to_many :users
  has_many :comments
  # has_many :tasks, :as => :author
  has_many :attachments, :dependent => :destroy

  validates_presence_of :name, :status_id, :due_date, :author_id

  scope :roots, where(:parent_id => nil)
  scope :active,  where("status_id != 4 and status_id != 6")
  scope :inactive, where("status_id = 4 or status_id = 6")
  scope :completed, where("status_id = 4")
  scope :cancelled, where("status_id = 6")  

  # before_save :update_informed


  def self.send_notifications(task, users)
    task = Task.find(task.id)
    emails = []
    users.each {|u| emails << User.find(u).email}
    UserMailer.task_email(task, emails).deliver
  end

  def assignees
    assignees = []
    self.users.each {|u| assignees << u.name }
    assignees.join(", ")
  end

  def has_children?
    self.children.count > 0 ? true : false
  end

  def has_attachments?
    self.attachments.count > 0 ? true : false
  end

  def active?
    if self.status_id == 4 or self.status_id == 6
      false
    else
      true
    end
  end


end
