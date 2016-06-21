class CreateTaskComments < ActiveRecord::Migration
  def change
    create_table :task_comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.string :content

      t.timestamps null: false
    end
  end
end
