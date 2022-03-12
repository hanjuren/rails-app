class BaseApi < Grape::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response({ message: 'Record not found' }.to_json, 404)
  end

  helpers do
    def server_port
      Rails.env['PORT'] || 3000
    end

    def token
      request.headers['Authorization'].to_s.gsub('Bearer ', '')
    end

    def decoded_jwt_token
      jwt_token = token
      error!("jwt-token missing error", 401) unless jwt_token.present?
      # decoded_token = JWT.decode token, hmac_secret, true, { exp_leeway: leeway, algorithm: 'HS256' }
      begin
        JWT.decode(jwt_token, ENV['JWT_SECRET'])
      rescue Exception => e
        error!("#{e.message}", 401)
      end
    end

    def authenticated_user
      # 뭔가 잘못된듯 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
      token = decoded_jwt_token.first.symbolize_keys!
      @authenticated_user ||= User.find(token[:id])
    end

    def current_user
      token = decoded_jwt_token.first.symbolize_keys!
      @current_user ||= User.find(token[:id])
    end
  end
end