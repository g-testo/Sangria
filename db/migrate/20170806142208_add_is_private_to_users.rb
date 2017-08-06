class AddIsPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_private, :boolean, default: false
  end
end
