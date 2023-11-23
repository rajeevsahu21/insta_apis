FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    post { nil }
    comment_id { 1 }
  end
end
