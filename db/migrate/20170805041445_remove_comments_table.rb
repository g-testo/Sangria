class RemoveCommentsTable < ActiveRecord::Migration
  def down
    drop_table :comments
  end
end
