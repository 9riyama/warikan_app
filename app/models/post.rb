class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}
  
  belongs_to :holder ,class_name: 'User',foreign_key: 'user_id'
  
  def user
    return User.find_by(id: self.user_id)
  end
  
end
