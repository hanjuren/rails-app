FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{DateTime.now.to_f}@example.com" }
    password { "test1234!@" }
  end
end