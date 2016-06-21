class CreateGoodjobs < ActiveRecord::Migration
  def change
    create_table :goodjobs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.integer :number

      t.timestamps null: false
    end
  end
end
