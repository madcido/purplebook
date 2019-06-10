class Like < ApplicationRecord
  belongs_to :user
  belongs_to :liked, polymorphic: true

  validates :user, uniqueness: { scope: :liked }
end
