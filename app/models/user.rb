class User < ApplicationRecord
  include BCrypt
  has_many :posts, :class_name => 'Post'

  def self.regist_user(params)
    params['password'] = encoded_password(params['password'])
    user = create(params)
    access_token = encoded_jwt_token({id: user.id}, "access")
    refresh_token = encoded_jwt_token({id: user.id}, "refresh")
    user.update({ access_token: access_token, refresh_token: refresh_token })
    user
  end

  private
  def self.encoded_password(password)
    Password.create(password)
  end

  def self.encoded_jwt_token(payload, type)
    payload[:exp] = type == "access" ? (30).minute.from_now.to_i : (1).week.from_now.to_i
    JWT.encode(payload, ENV['JWT_SECRET'])
  end
end
