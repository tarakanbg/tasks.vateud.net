class Attachment < ActiveRecord::Base
  attr_accessible :name, :task_id, :upload, :upload_file_name, :upload_content_type,
                  :upload_file_size, :upload_updated_at
  has_attached_file :upload

  belongs_to :task

  validates :upload, attachment_presence: true, presence: true
  validates :name, presence: true
  validates :task_id, presence: true
end
