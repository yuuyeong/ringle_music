FactoryBot.define do
  sequence(:title) { |n| "album title#{n}" }

  factory :album do
    title { generate :title }
    image_url { "http://localhost:3000/test.png" }
    release_date do
      from = 2.years.ago.to_f
      to = Time.now.to_f
      Time.at(from + rand * (to - from))
    end
    total_tracks { rand(1..15) }

    association :artist
  end
end