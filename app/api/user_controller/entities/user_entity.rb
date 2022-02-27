module UserController
  module Entities
    class UserEntity < Grape::Entity
      expose *%i(id name nick_name age gender)
    end
  end
end