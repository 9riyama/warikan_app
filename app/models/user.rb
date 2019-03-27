class User < ApplicationRecord
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  has_many :posts 
  has_many :categories, through: :posts
  
  def posts
    return Post.where(user_id: self.id)
  end
  
  def month_posts
    return Post.where(user_id: self.id).group("pay_month").order(pay_month: "desc")
  end
  
  
end