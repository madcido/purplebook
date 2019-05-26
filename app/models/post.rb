class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  
  has_many :likes, as: :liked, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  default_scope { order("created_at DESC") }

  validates :content, presence: true, unless: Proc.new { |post| post.image.attached? }
  
  def purge
    @purge ||= "keep"
  end

end
