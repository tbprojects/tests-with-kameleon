class Task < ActiveRecord::Base

  PRIORITY_LIST = %w(Critical High Normal Low)
  STATUS_LIST = %w(New Opened Feedback Closed)
  PROGRESS_LIST = (0..100).step(10).map{|i|"#{i}%"}

  belongs_to :project
  belongs_to :user

  validates :name, :user_id, :project_id, :priority, :progress, :status, :presence => true

  acts_as_commentable
  accepts_nested_attributes_for :comments

  scope :not_closed, where("status is not 'Closed'")

  def can_be_managed_by?(user)
    project.manager == user or self.user == user
  end

end
