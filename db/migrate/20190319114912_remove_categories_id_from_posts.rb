class RemoveCategoriesIdFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :Category_id, :integer
  end
end
