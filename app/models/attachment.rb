class Attachment < ActiveRecord::Base
  attr_accessible :name, :task_id, :upload, :upload_file_name, :upload_content_type,
                  :upload_file_size, :upload_updated_at
  has_attached_file :upload

  belongs_to :task
end
