class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.has_attached_file :picto
      t.integer :project_id
      t.timestamps
    end
  end
end
