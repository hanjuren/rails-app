class UserApi < BaseApi

  resource 'users' do
    helpers do
      def post_params
        params.as_json(only: %i[email password name nick_name age gender])
      end
    end
    # GET /api/v1/users/all
    get 'all' do
      users = User.all
      # TODO grape-entity
      {
        total: users.count,
        result: users,
      }
    end

    # POST /api/v1/users
    post do
      User.create(post_params)
    end

    # POST /api/v1/users/regist
    post 'regist' do
      User.regist_user(post_params)
    end
  end
end