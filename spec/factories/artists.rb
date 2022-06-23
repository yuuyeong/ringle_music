FactoryBot.define do
  sequence(:name_kr) { |n| "가나다#{n}" }
  sequence(:name_eng) { |n| "test#{n}" }

  factory :artist do
    name_kr { generate :name_kr }
    name_eng { generate :name_eng }
    image_url { "http://localhost:3000/test.png" }
  end
end