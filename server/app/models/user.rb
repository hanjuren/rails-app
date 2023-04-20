class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  class << self
    def sign_in_social(provider, code, redirect_uri)
      if provider == 'kakao'
        tokens = get_kakao_tokens(code, redirect_uri)
        data = get_kakao_user_data(tokens[:access_token])

        # email 동의 안할 수 있음
        uid = data['id']
        nick_name = data.dig('kakao_account', 'profile', 'nickname')
        email = data.dig('kakao_account', 'email')
        email = "#{uid}@kakao.com"unless email.present?

        user = User.find_by(email: email, uid: uid, provider: provider)
        if user.nil?
          user = User.new(
            email: email,
            uid: uid,
            provider: provider,
            nick_name: nick_name,
          )
          user.save(validate: false) # 혹은 랜덤 비밀번호 넣을지 고민
        end

        user
      else
        ""
      end
    end

    def get_kakao_tokens(code, redirect_uri)
      url = "https://kauth.kakao.com/oauth/token"
      payload = {
        grant_type: "authorization_code",
        client_id: ENV['rest_api_key'],
        client_secret: ENV['client_secret'],
        code: code,
        redirect_uri: redirect_uri,
      }
      headers = { "content-type" => "application/x-www-form-urlencoded;charset=utf-8" }

      begin
        res = RestClient.post(
          url,
          payload,
          headers,
          )
        body = JSON.parse(res.body)

        {
          access_token: body["access_token"],
          refresh_token: body["refresh_token"],
        }
      rescue => e
        Rails.logger.info("카카오 토큰 API 요청 실패")
        Rails.logger.info(e.message)
      end
    end

    def get_kakao_user_data(access_token)
      url = "https://kapi.kakao.com/v2/user/me"
      headers = {
        "authorization" => "Bearer #{access_token}",
      }

      begin
        res = RestClient.post(url, {}, headers)
        JSON.parse(res.body)
      rescue => e
        Rails.logger.info("카카오 유저 데이터 요청 실패")
        Rails.logger.info(e.message)
      end
    end
  end

  def after_sign_in(current_ip)
    update!(
      current_sign_in_at: DateTime.now,
      current_sign_in_ip: current_ip,
      last_sign_in_at: self.current_sign_in_at.present? ? self.current_sign_in_at : nil,
      last_sign_in_ip: self.current_sign_in_ip.present? ? self.current_sign_in_ip : nil,
    )
  end
end
