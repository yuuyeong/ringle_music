FactoryBot.define do
  factory :playlist_track do
    association :playlist, :track
  end
end