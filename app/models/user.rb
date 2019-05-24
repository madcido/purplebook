class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :liked, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :liked, source_type: "Comment"

  has_many :sent_requests, class_name: "FriendRequest", foreign_key: :sender_id, dependent: :destroy
  has_many :received_requests, class_name: "FriendRequest", foreign_key: :receiver_id, dependent: :destroy

  def requests
    self.sent_requests.or(self.received_requests)
  end

end
