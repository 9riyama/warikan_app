class Post < ApplicationRecord
  
  validates :user_id, presence: true
  validates :payment, presence: true
  validates :content, length: {maximum: 140}

  belongs_to :user
  belongs_to :category

end
