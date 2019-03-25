class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :partner_name
      t.string :email
      t.string :password_digest
      t.string :image_name
      t.string :image_partner

      t.timestamps
    end
  end
end
