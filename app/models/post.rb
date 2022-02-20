class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', optional: true, foreign_key: :user_id
end
