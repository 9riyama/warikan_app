class AddColumnRemoveColumn < ActiveRecord::Migration[5.1]
  def change
    
    add_column :posts, :payment, :integer
    
    remove_column :posts, :house_cost, :integer
    remove_column :posts, :gas_cost, :integer
    remove_column :posts, :electric_cost, :integer
    remove_column :posts, :water_cost, :integer
    remove_column :posts, :total_cost, :integer
    remove_column :posts, :user_total_cost, :integer
    remove_column :posts, :partner_total_cost, :integer
  end
end
