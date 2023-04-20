module API
  module V1
    class All < Base
      version 'v1', using: :path
      format :json
      prefix :api

      mount AuthenticateAPI

      get 'meta' do
        {
          message: 'alive',
        }
      end
    end
  end
end