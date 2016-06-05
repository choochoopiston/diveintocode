class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :course
      t.string :category
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
