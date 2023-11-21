require 'factory_bot_rails'

FactoryBot.define do
  factory :post do
    caption { Faker::Lorem.sentence }
    location { Faker::Address.city }
    association :user, factory: :user
  end
end
