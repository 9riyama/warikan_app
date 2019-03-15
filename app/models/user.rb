class User < ApplicationRecord
  has_secure_password
  
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  
  has_many :posts 
  
  def posts
    return Post.where(user_id: self.id)
  end
  
  def month_posts
    return Post.where(user_id: self.id).group("pay_month").order(pay_month: "desc")
  end
  
  
end