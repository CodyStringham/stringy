class Home < ActiveRecord::Base
  attr_accessible :email, :message, :name, :subject
  validates :email, :message, :name, :subject, presence: true
end
