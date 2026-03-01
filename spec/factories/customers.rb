FactoryBot.define do
  factory :customer do
    company_name { "テスト会社" }
    contact_name { "山田太郎" }
    email { "customer@example.com" }
    phone { "090-0000-0000" }
    status { :in_progress }
    association :user
  end
end
