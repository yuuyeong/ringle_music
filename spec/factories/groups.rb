FactoryBot.define do
  factory :group do
    name { 'group name' }
    owner { association :user }
  end
end