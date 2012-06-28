class AddStatusAndProgressToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :string, :default => Task::STATUS_LIST.first
    add_column :tasks, :progress, :string, :default => Task::PROGRESS_LIST.first
  end
end
