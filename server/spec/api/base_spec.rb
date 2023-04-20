require 'rails_helper'

RSpec.describe "Bases", type: :request do
  describe "GET /meta" do
    it "returns http success" do
      get "/api/v1/meta"
      expect(response).to have_http_status(:success)
    end
  end

end
