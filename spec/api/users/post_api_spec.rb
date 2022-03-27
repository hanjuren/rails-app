require 'rails_helper'

RSpec.describe 'PostApi' do

  describe 'CRUD' do
    let(:user) { FactoryBot.create(:user) }
    describe 'GET /api/v1/posts' do
      let(:post) { FactoryBot.create(:post, user_id: user.id) }
      it '' do
        post.reload
        get req("/posts")
        expect(response.status).to eq(200)
        expect(res[:total]).to eq(1)
        expect(res[:records].count).to eq(1)
      end
    end
  end
end