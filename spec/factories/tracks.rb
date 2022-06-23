FactoryBot.define do
  sequence(:track_title) { |n| "track title#{n}" }

  factory :track do
    title { generate :track_title }
    duration { "1:01" } 
    
    association :artist, :album
  end
end