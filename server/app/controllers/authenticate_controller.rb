require 'rest-client'

class AuthenticateController < ApplicationController
  def sign_up
    exists = User.exists?(email: params[:email])
    if exists
      render json: { status: "FAIL", message: "User already exists." }, status: 400
      return
    end

    user = User.new(email: params[:email], password: params[:password])
    result = {}
    if user.save
      status = :created
      result[:status] = "SUCCESS"
      result[:message] = "Create User Success."
    else
      status = :bad_request
      result[:status] = "FAIL"
      result[:message] = user.errors.full_messages.join(', ')
    end

    render json: result, status: status
  end

  def sign_in
    user = User.find_by_email(params[:email])

    unless user
      return render(
        json: { message: "Record not found." },
        status: :not_found,
      )
    end

    valid = user.valid_password?(params[:password])
    unless valid
      return render(
        json: { message: "Password does not match." },
        status: :unauthorized,
      )
    end

    ip = request.remote_ip
    user.after_sign_in(ip)

    render(
      json: UserSerializer.new(user).serializable_hash,
      status: :created,
    )
  end

  def kakao_login
    Rails.logger.info("kakao login---------------------------\n\n\n\n")
    Rails.logger.info(params)
    url = get_authorize_url
    Rails.logger.info(url)

    Rails.logger.info("\n\n\n\n---------------------------")

    redirect_to url, allow_other_host: true
  end

  def kakao_callback
    code = params[:code]

    tokens = get_kakao_token(code)
    data = get_me(tokens[:access_token])
    Rails.logger.info("callback---------------------------\n\n\n\n")
    Rails.logger.info(data)
    Rails.logger.info("\n\n\n\n---------------------------")

    redirect_to "http://localhost:8080", allow_other_host: true
  end

  private
  def get_authorize_url
    payload = {
      client_id: "304eb08fa8bf41613f2c9b6aece62720",
      redirect_uri: "http://localhost:3000/api/v1/auth/kakao-callback",
      response_type: "code",
    }
    query = URI.encode_www_form(payload)

    "https://kauth.kakao.com/oauth/authorize?#{query}"
  end

  def get_kakao_token(code)
    url = "https://kauth.kakao.com/oauth/token"
    payload = {
      grant_type: "authorization_code",
      client_id: "304eb08fa8bf41613f2c9b6aece62720",
      redirect_uri: "http://localhost:3000/api/v1/auth/kakao-callback",
      code: code,
      client_secret: "n1OpK03cwEMKbfjCphzQZFuRZXcJ9FDr",
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
      Rails.logger.info(e)
    end
  end

  def get_me(access_token)
    url = "https://kapi.kakao.com/v2/user/me"
    headers = {
      "authorization" => "Bearer #{access_token}",
    }

    begin
      res = RestClient.post(url, {}, headers)
      body = JSON.parse(res.body)

      body
    rescue => e
      Rails.logger.info(e)
    end
  end
end
