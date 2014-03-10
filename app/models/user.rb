class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :task_ids, :position,
                  :vatsimid, :vacc

  has_paper_trail

  has_and_belongs_to_many :tasks
  has_many :comments

  validates_presence_of :name, :email, :position, :vatsimid, :vacc
  validates :name, :length => { :minimum => 4 }
  validates :vatsimid, :length => { :minimum => 6 }
  validates :vatsimid, :numericality => true

  #default_scope order('name ASC')

  scope :staff, where(:staff => true)
  scope :nonstaff, where(:staff => false)
  scope :admins, where(:admin => true)

  attr_reader :name_position
  attr_reader :authored_tasks
  attr_reader :deletable

  after_create :email_admins

  def email_admins
    admins = User.admins    
    emails = []
    admins.each {|u| emails << u.email}    
    UserMailer.delay.new_user_admins_email(self.id, emails) if emails.count > 0
  end

  def name_position
    "#{self.name} (#{self.position})"
  end

  def authored_tasks
    Task.where(:author_id => self.id)
  end

  def deletable?
    self.tasks.count == 0 && self.comments.count == 0 ? true : false
  end
end
