class AddCategoriesIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :categories, foreign_key: true
  end
end
