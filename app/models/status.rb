class Status < ActiveRecord::Base
  attr_accessible :css, :name, :priority
  has_many :tasks
end
