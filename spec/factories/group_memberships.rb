FactoryBot.define do
  factory :group_membership do
    association :user, :group
  end
end