require 'rails_helper'

RSpec.describe 'UserApi' do
  # GET /api/v1/users/all
  describe 'GET /api/v1/users/all' do
    before '2.times create users' do
      2.times do
        FactoryBot.create(:user)
      end
    end
    it do
      get req('/users/all')
      expect(response.status).to eq(200)
      expect(res[:total]).to eq(2)
      expect(res[:result].count).to eq(2)
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
end