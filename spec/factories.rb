include BCrypt
FactoryBot.define do
  factory :user, aliases: [:author] do
    email { "test@gmail.com" }
    password { Password.create("test") }
    access_token { nil }
    refresh_token { nil }
    name { "test_user01" }
    nick_name { "test_user_nick" }
    age { 26 }
    gender { "man" }
  end

  factory :post do
    title { "test_post_title" }
    content { "test" }
    thumb_nail_image_src { nil }

    user_id { FactoryBot.create(:user).id }
  end
end


