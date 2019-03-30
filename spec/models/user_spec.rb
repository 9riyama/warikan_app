require 'rails_helper'

RSpec.describe User, type: :model do
  
  #名前、メール、パスワードがあれば有効な状態であること
  it "is valid with a name, email, and password" do
    user = User.new(
        name: "テスト太郎",
        email: "tester@example.com" ,
        password: "dottle-nouveau-pavilion-tights-furze"
    )
    expect(user).to be_valid
  end
  
  
  # 名前がなければ無効な状態であること
  it "is invalid without a first name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
   user = User.new(email: nil)
   user.valid?
   expect(user.errors[:email]).to include("を入力してください")
  end
  
  
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
        name: "テスト太郎",
        email: "tester@example.com" ,
        password: "dottle-nouveau-pavilion-tights-furze"
    )
    user = User.new(
        name: "テスト花子",
        email: "tester@example.com" ,
        password: "dottle-nouveau-pavilion-tights-furze"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  
  
  
  # パスワードがなければ無効な状態であること
  it "is invalid without an password" do
     user = User.new(password: nil)
   user.valid?
   expect(user.errors[:password]).to include("を入力してください")
  end
  
  
end