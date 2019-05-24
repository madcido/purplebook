class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :likes, as: :liked, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :content, presence: true, length: {maximum: 300}
end
