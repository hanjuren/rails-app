require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Association' do
    it { is_expected.to belong_to(:user).optional }
  end
end
