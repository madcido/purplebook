FactoryBot.define do
    factory :post do
        association :user, factory: :user
        content { Faker::ChuckNorris.fact }
    end
end
