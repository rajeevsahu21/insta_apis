FactoryBot.define do
  factory :tag do
    association :user, factory: :user
    association :post, factory: :post
  end
end
