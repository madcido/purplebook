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

  has_many :sent_relations, class_name: "Relation", foreign_key: :sender_id, dependent: :destroy
  has_many :received_relations, class_name: "Relation", foreign_key: :receiver_id, dependent: :destroy

  def relations
    self.sent_relations.or(self.received_relations)
  end

end
