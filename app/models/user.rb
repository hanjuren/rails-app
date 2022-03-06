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

  def self.sign_in_app(email, password)
    user = User.find_by_email(email)
    if user.present?
      if decoded_password(password, user.password)
        user.update({
          access_token: encoded_jwt_token({id: user.id}, "access"),
          refresh_token: encoded_jwt_token({id: user.id}, "refresh"),
          last_sign_in_at: DateTime.now,
        })
        user
      else
        raise Exception.new('wrong password')
      end
    else
      raise Exception.new('Not Found')
    end
  end

  private
  def self.encoded_password(password)
    Password.create(password)
  end

  def self.decoded_password(params_pwd, my_pwd)
    password = Password.new(my_pwd)
    password == params_pwd
  end

  def self.encoded_jwt_token(payload, type)
    payload[:exp] = type == "access" ? (30).minute.from_now.to_i : (1).week.from_now.to_i
    JWT.encode(payload, ENV['JWT_SECRET'])
  end
end
