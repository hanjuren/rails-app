module UserController
  module Entities
    class UserEntity < Grape::Entity
      expose *%i(id name nick_name age gender access_token refresh_token)
    end
  end
end