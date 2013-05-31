class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :task_ids, :position,
                  :vatsimid, :vacc
  # attr_accessible :title, :body

  has_and_belongs_to_many :tasks
  has_many :comments

  validates_presence_of :name, :email, :position, :vatsimid, :vacc
  validates :name, :length => { :minimum => 4 }
  validates :vatsimid, :length => { :minimum => 6 }
  validates :vatsimid, :numericality => true

  default_scope order('name ASC')

  scope :staff, where(:staff => true)
  scope :nonstaff, where(:staff => false)

  attr_reader :name_position
  attr_reader :authored_tasks

  def name_position
    "#{self.name} (#{self.position})"
  end

  def authored_tasks
    Task.where(:author_id => self.id)
  end
end
