FactoryBot.define do
  sequence(:playlist_name) { |n| "playlist#{n}" }

  factory :playlist do
    name { generate :playlist_name }

    trait :for_group do
      association :playlistable, factory: :group
    end

    trait :for_user do
      association :playlistable, factory: :user
    end
  end
end