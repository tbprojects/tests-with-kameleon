class Task < ActiveRecord::Base

  PRIORITY_LIST = %w(Critical High Normal Low)

  belongs_to :project
  belongs_to :user

  validates :name, :user_id, :project_id, :priority, :presence => true

  def can_be_managed_by?(user)
    project.manager == user or self.user == user
  end

end
