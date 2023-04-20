module API
  module V1
    class AuthenticateAPI < Base
      desc '이메일 회원가입'
      params do
        requires :email, type: String, desc: '이메일'
        requires :password, type: String, desc: '비밀번호'
      end
      post 'sign_up' do
        exists = User.exists?(email: params[:email])
        if exists
          error!({ status: "fail", message: "User already exists." }, 400)
        end

        user = User.new(email: params[:email], password: params[:password])
        if !user.save
          error!({ status: 'fail', message: user.errors.full_messages.join(", ") }, 400)
        else
          # TODO: Grape::Entity
          present user
        end
      end

      desc '이메일 로그인'
      params do
        requires :email, type: String, desc: '이메일'
        requires :password, type: String, desc: '비밀번호'
      end
      post 'sign_in' do
        user = User.find_by(email: params[:email])

        unless user
          error!({ status: 'fail', message: "Record not found." }, 404)
        end

        valid = user.valid_password?(params[:password])
        unless valid
          error!({ status: 'fail', message: "Password does not match." }, 401)
        end

        user.after_sign_in(env['REMOTE_ADDR'])

        present user
      end

      desc '카카오 로그인'
      params do
        requires :code, type: String, desc: '카카오에서 받은 인가코드'
        requires :redirect_uri, type: String, desc: '카카오 리다이렉트 URI'
      end
      post 'sign_in_kakao' do
        provider = 'kakao'
        user = User.sign_in_social(
          provider,
          params[:code],
          params[:redirect_uri],
        )

        present user
      end
    end
  end
end