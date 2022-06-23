FactoryBot.define do
  sequence(:name) { |n| "test#{n}" }

  factory :user do
    name { generate :name }
    email { "#{name}@example.com".downcase }
    password { "qwer1324" }
  end
end