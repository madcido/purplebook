class Friendship < ApplicationRecord
    attr_readonly :sender_id, :receiver_id

    scope :accepted, -> { where(pending: false) }
    scope :pending, -> { where(pending: true) }

    belongs_to :sender, class_name: "User"
    belongs_to :receiver, class_name: "User"

    validate :not_friends, on: :create
    validate :not_same

    def not_friends
        query = ["sender_id = #{sender_id} AND receiver_id = #{receiver_id} OR sender_id = #{receiver_id} AND receiver_id = #{sender_id}"]
        errors.add(:sender, "and receiver already friends") if Friendship.where(query).exists?
    end

    def not_same
        errors.add(:sender, "can't be friends with self") if sender_id == receiver_id
    end

end
