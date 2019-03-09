class AddPostsColumnCost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :house_cost, :integer
    add_column :posts, :gas_cost, :integer
    add_column :posts, :electric_cost, :integer
    add_column :posts, :water_cost, :integer
  end
end
