require 'rails_helper'

RSpec.describe User, type: :model do

  it "名前、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
        name: "テスト太郎",
        email: "tester@example.com" ,
        password: "dottle-nouveau-pavilion-tights-furze"
    )
    expect(user).to be_valid
  end
  
  it "名前がなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "パスワードがなければ無効な状態であること" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスなら無効な状態であること" do
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
  
  it "名前が51文字以上で無効な状態であること" do
    user = User.new(name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  
  it "メールアドレスが256文字以上で無効な状態であること" do
    user = User.new(email: "a" * 244 + "@example.com")
    user.valid?
    expect(user.errors[:email]).to include("は255文字以内で入力してください")
  end
  
  it "パスワードが5文字以内で無効な状態であること" do
    user = User.new
    user.password = user.password_confirmation = "a" * 5
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
  
  it "パスワードが6文字以上の空文字が入力された場合無効な状態であること" do
    user = User.new
    user.password = user.password_confirmation = " " * 6
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
end