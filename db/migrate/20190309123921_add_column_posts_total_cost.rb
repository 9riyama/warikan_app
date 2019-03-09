class AddColumnPostsTotalCost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :total_cost, :integer
  end
end
