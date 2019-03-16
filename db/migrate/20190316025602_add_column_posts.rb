class AddColumnPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :categories_id, :integer
  end
end
