class Project < ActiveRecord::Base

  has_many :pictures, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  belongs_to :manager, :class_name =>  "User", :foreign_key => :manager_id
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  validates :name, :uniqueness => true
  validates :name, :manager_id, :presence => true

  def can_be_managed_by?(user)
    manager == user
  end

end
