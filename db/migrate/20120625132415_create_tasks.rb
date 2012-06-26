class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :priority
      t.text :description
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
