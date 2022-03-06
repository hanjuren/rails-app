require 'rails_helper'

RSpec.describe 'UserApi' do
  # GET /api/v1/users/all
  describe 'GET /api/v1/users/all' do
    let(:user) { FactoryBot.create(:user) }
    it 'Signature has expired' do
      payload = { id: user.id, exp: 5.minute.ago.to_i }
      token = JWT.encode(payload, ENV['JWT_SECRET'])
      get req('/users/all'),
          headers: { 'Authorization' => "Bearer #{token}"}
      expect(response.status).to eq(401)
    end
    it '' do
      payload = { id: user.id, exp: 5.minute.from_now.to_i }
      token = JWT.encode(payload, ENV['JWT_SECRET'])
      get req('/users/all'),
          headers: { 'Authorization' => "Bearer #{token}"}
      expect(response.status).to eq(200)
    end
  end
  # POST /api/v1/users
  describe 'POST /api/v1/users' do
    it do
      post req('/users'), params: {
        email: 'juren52@hanmail.net',
        password: 'test',
        name: 'test_user',
        nick_name: 'test',
        age: 26,
        gender: 'man'
      }
      expect(response.status).to eq(201)
    end
  end
  # POST /api/v1/users/regist
  describe 'POST /api/v1/users/regist' do
    it do
      post req('/users/regist'), params: {
        email: 'juren52@hanmail.net',
        password: 'test',
        name: 'test_user',
        nick_name: 'test',
        age: 26,
        gender: 'man'
      }
      pp res
    end
  end

  describe 'POST /api/v1/users/sign_in' do
    before do
      post req('/users/regist'), params: {
        email: 'test@hanmail.net',
        password: '1234',
        name: 'test_user',
        nick_name: 'test',
        age: 26,
        gender: 'man'
      }
    end
    it 'not found error' do
      post req("/users/sign_in"), params: { email: 'test1@hanmail.net', password: '1234' }
      expect(response.status).to eq(404)
    end
    it 'wrong password' do
      post req("/users/sign_in"), params: { email: 'test@hanmail.net', password: 'wrong_password' }
      expect(response.status).to eq(401)
    end
    it 'sign_in app' do
      post req("/users/sign_in"), params: { email: 'test@hanmail.net', password: '1234' }
      expect(response.status).to eq(201)
      expect(res[:access_token].present?).to be_truthy
      expect(res[:refresh_token].present?).to be_truthy
    end
  end
end