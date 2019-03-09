class AddColumnPostsPayName < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :user_total_cost, :integer
    add_column :posts, :partner_total_cost, :integer
    add_column :posts, :pay_name, :string
  end
end
