class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user
  
  has_many :likes, as: :liked, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  default_scope { order("created_at DESC") }

  validates :content, presence: true, unless: Proc.new { |post| post.image.attached? }
  validates :user, uniqueness: { scope: :shared_from_id },  if: :shared_from_id
  
  def purge
    @purge ||= "keep"
  end

  def share
    @share = nil
  end

  def sharers
    User.joins(:posts).where(posts: { shared_from_id: self.shared_from_id || self.id  })
  end

end
