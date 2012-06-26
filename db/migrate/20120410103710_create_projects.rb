class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :active
      t.integer :manager_id
      t.timestamps
    end
  end
end
