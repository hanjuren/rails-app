module UserController
  class UserApi < BaseApi

    resource 'users' do
      helpers do
        def post_params
          params.as_json(only: %i[email password name nick_name age gender])
        end # post params

        def put_params
          params.as_json(only: %i[email name nick_name age gender])
        end # put params
      end # helpers

      # GET /api/v1/users/all
      get 'all' do
        authenticated_user

        users = User.limit(101)
        # TODO grape-entity
        {
          total: users.count,
          result: users.map { |r| Entities::UserEntity.represent(r) },
        }
      end # get /all

      # POST /api/v1/users/regist
      post 'regist' do
        user = User.regist_user(post_params)

        present user, with: Entities::UserEntity
      end # post /regist

      # POST /api/v1/users/sign_in
      post 'sign_in' do
        begin
          user = User.sign_in_app(params[:email], params[:password])
          present user, with: Entities::UserEntity

        rescue Exception => e
          case e.message

          when 'Not Found'
            error!({ "message" =>"Not Found Error" }, 404)
          when 'wrong password'
            error!({ "message" => "#{e.message}" }, 401)
          else
            error!({ "message" => "server error" }, 500)
          end # case
        end # begin rescue
      end # # post /sign_in

      # PUT /api/v1/users/:user_id
      put ':user_id/' do
        error!({ message: 'Forbidden Error!' }, 403) if authenticated_user.id != params[:user_id]

        user = @authenticated_user.update(put_params)
        present user, with: Entities::UserEntity
      end # put /:user_id

    end # resource: 'users'
  end # class UserAPI
end # module UserController