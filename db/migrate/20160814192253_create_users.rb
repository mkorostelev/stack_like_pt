class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :is_admin, default: false
      t.string :token
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end

    add_index :users, :token, unique: true
  end
end

