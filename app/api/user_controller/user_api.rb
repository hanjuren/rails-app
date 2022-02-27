module UserController
  class UserApi < BaseApi

    resource 'users' do
      helpers do
        def post_params
          params.as_json(only: %i[email password name nick_name age gender])
        end
      end
      # GET /api/v1/users/all
      get 'all' do
        users = User.limit(101)
        # TODO grape-entity
        {
          total: users.count,
          result: users.map { |r| Entities::UserEntity.represent(r) },
        }
      end

      # POST /api/v1/users
      post do
        User.create(post_params)
      end

      # POST /api/v1/users/regist
      post 'regist' do
        user = User.regist_user(post_params)
        present user, with: Entities::UserEntity
      end
    end
  end
end