class RenameTitrlColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :categories_id, :category_id
  end
end
