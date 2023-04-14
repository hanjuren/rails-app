require 'rails_helper'

RSpec.describe "Authenticate", type: :request do
  describe "POST auth/sign_up" do
    let(:user) { FactoryBot.create(:user, email: "juren52@naver.com") }

    it 'Already exists' do
      expect(user.persisted?).to be_truthy

      post "/api/v1/auth/sign_up", params: { email: "juren52@naver.com", password: "test1234!@" }
      expect(response).to have_http_status(:bad_request)
    end

    it 'Validation error' do
      post "/api/v1/auth/sign_up", params: { email: "juren52", password: "test1234!@" }
      pp response.status
      expect(response).to have_http_status(:bad_request)
    end

    it 'Create new user' do
      expect {
        post "/api/v1/auth/sign_up", params: { email: "juren52@naver.com", password: "test1234!@" }
        expect(response).to have_http_status(:created)
      }.to change { User.count }.by(1)
    end
  end

  describe 'POST /auth/sign_in' do
    before do
      post "/api/v1/auth/sign_up", params: { email: "juren52@naver.com", password: "test1234!@" }
    end

    it 'Cannot find user with email.' do
      post "/api/v1/auth/sign_in", params: { email: "xxxx111@naver.com", password: "test123213!" }
      expect(response).to have_http_status(:not_found)
    end

    it 'Invalid password' do
      post "/api/v1/auth/sign_in", params: { email: "juren52@naver.com", password: "test1234!" }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'Sign-in' do
      post "/api/v1/auth/sign_in", params: { email: "juren52@naver.com", password: "test1234!@" }
      pp json_response
    end
  end
end
