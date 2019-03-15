class RenameTitreColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :pay_date, :pay_month
  end
end
