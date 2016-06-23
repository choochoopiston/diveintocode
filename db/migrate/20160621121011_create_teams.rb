class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :project_id
      t.integer :mate_id

      t.timestamps null: false
    end
    add_index :teams, :project_id
    add_index :teams, :mate_id
    add_index :teams, [:project_id, :mate_id], unique: true
  end
end
