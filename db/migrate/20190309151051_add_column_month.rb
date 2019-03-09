class AddColumnMonth < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :pay_date, :date
  end
end
