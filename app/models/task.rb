class Task < ActiveRecord::Base
  attr_accessible :active, :author_id, :description, :due_date, :name, :status_id, :user_ids,
                  :parent_id, :lft, :rgt
  attr_reader :assignees

  acts_as_nested_set

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :status
  has_and_belongs_to_many :users
  has_many :tasks, :as => :author
  has_many :attachments, :dependent => :destroy

  validates_presence_of :name, :status_id, :due_date, :author_id

  scope :roots, where(:parent_id => nil)
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)


  def assignees
    assignees = []
    self.users.each {|u| assignees << u.name }
    assignees.join(", ")
  end

  def has_children?
    self.children.count > 0 ? true : false
  end


end
