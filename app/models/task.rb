class Task < ActiveRecord::Base
  attr_accessible :author_id, :description, :due_date, :name, :status_id, :user_ids,
                  :parent_id, :lft, :rgt, :informed, :private

  serialize :informed                
  attr_reader :assignees
  attr_reader :due_date_style

  acts_as_nested_set
  has_paper_trail

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :status
  has_and_belongs_to_many :users
  has_many :comments, :dependent => :destroy
  # has_many :tasks, :as => :author
  has_many :attachments, :dependent => :destroy

  validates_presence_of :name, :status_id, :due_date, :author_id
  validate :not_past_date

  scope :roots, where(:parent_id => nil)
  scope :private, where(:private => true)
  scope :public, where(:private => false)
  scope :active,  where("status_id != 4 and status_id != 6")
  scope :inactive, where("status_id = 4 or status_id = 6")
  scope :completed, where("status_id = 4")
  scope :cancelled, where("status_id = 6")  

  # before_save :update_informed
  # after_save :email_author

  def not_past_date
    if self.due_date.past?
      errors.add(:due_date, 'Cannot be past')
    end
  end

  # def email_author
    # if self.status_id_changed? && self.users.include?(self.author) == false
    #   UserMailer.author_status_email(self).deliver
    # end 
  # end


  def self.send_notifications(task, users)
    task = Task.find(task.id)
    emails = []
    users.each {|u| emails << User.find(u).email}
    UserMailer.delay.task_email(task, emails)
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

  def due_date_style
    if self.due_date && self.due_date.past? && self.active?
      "text-error"
    elsif self.due_date && self.due_date < 7.days.from_now.to_date && self.active?
      "text-warning"    
    end
  end

end
