class RemovePasswordFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :password
    remove_column :users, :password_confirmation
  end
end
