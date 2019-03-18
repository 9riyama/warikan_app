class AddColumnUsersImage < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_partner, :string
  end
end
