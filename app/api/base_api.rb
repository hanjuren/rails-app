class BaseApi < Grape::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response({ message: 'Record not found' }.to_json, 404)
  end

  helpers do
    def server_port
      Rails.env['PORT'] || 3000
    end
  end
end