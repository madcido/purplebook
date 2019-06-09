FactoryBot.define do
    factory :post_like, class: "Like" do
        liked_type { "Post" }
        association :liked, factory: :post
        association :user, factory: :user
    end

    factory :comment_like, class: "Like" do
        liked_type { "Comment" }
        association :liked, factory: :comment
        association :user, factory: :user
    end
end
