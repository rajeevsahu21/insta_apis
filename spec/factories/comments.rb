FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :user, factory: :user
    association :post, factory: :post
    comment_id { 1 }
  end
end
