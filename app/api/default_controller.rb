require 'users/user_api' # UserApi

class DefaultController < BaseApi
  version 'v1', using: :path
  format :json
  prefix :api

  get 'alive' do
    "rails server run #{server_port} port"
  end

  mount UserApi
end