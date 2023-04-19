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
    user = User.find_by(email: params[:email])

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
    user = User.sign_in_social(params[:provider], params[:code], params[:redirect_uri])

    render json: UserSerializer.new(user).serializable_hash, status: :created
  end

  private

end
