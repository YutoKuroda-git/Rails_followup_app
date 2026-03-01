FactoryBot.define do
  factory :interaction do
    contact_type { :email }
    summary { "テスト対応" }
    action_taken { "次回連絡" }
    contacted_at { Time.current }
    association :user
    association :customer
  end
end
