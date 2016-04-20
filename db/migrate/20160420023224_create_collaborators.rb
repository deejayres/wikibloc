class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|

      t.integer :user_id
      t.integer :wiki_id
      t.timestamps null: false
    end

    add_index :collaborators, :id, unique: true
    add_index :collaborators, :user_id
    add_index :collaborators, :wiki_id
  end
end
