class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :kind, default: 0
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :likeable_id
      t.string  :likeable_type

      t.timestamps null: false
    end

    add_index :likes, [:likeable_type, :likeable_id]
  end
end
