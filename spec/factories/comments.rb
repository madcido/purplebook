FactoryBot.define do
    factory :comment do
        association :post, factory: :post
        association :user, factory: :user
        content { Faker::ChuckNorris.fact }
    end
end
