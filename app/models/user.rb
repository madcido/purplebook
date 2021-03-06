class User < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

    has_one_attached :avatar
    has_one_attached :cover

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :liked_posts, through: :likes, source: :liked, source_type: "Post"
    has_many :liked_comments, through: :likes, source: :liked, source_type: "Comment"

    has_many :sent_requests, class_name: "Friendship", foreign_key: :sender_id, dependent: :destroy
    has_many :received_requests, class_name: "Friendship", foreign_key: :receiver_id, dependent: :destroy

    default_scope { order("name ASC") }

    validates :name, length: { maximum: 20 }

    def friends
        User.where(id: self.sent_requests.accepted.pluck(:receiver_id)).or(User.where(id: self.received_requests.accepted.pluck(:sender_id)))
    end

    def pending_friends
        User.where(id: self.received_requests.pending.pluck(:sender_id))
    end

end
