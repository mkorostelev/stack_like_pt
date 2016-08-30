class AddIsDeletedToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :is_deleted, :boolean, default: false
  end
end
