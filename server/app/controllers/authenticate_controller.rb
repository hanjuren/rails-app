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

    result = {}
    if user.present?
      if user.valid_password?(params[:password])
        ip = request.remote_ip
        user.after_sign_in(ip)

        status = :created
        result = {
          status: "SUCCESS",
          message: "Sign-In success",
          data: UserSerializer.new(user),
        }
      else
        status = :unauthorized
        result = { status: "FAIL", message: "Password does not match." }
      end
    else
      status = :not_found
      result = { status: "FAIL", message: "Record not found" }
    end


    render json: result, status: status
  end
end
