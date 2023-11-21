require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      post = build(:post)
      expect(post).to be_valid
    end

    it 'is not valid without a user' do
      post = build(:post, user: nil)
      expect(post).to_not be_valid
    end

    it 'is valid without a caption' do
      post = build(:post, caption: nil)
      expect(post).to be_valid
    end

    it 'is valid without a location' do
      post = build(:post, location: nil)
      expect(post).to be_valid
    end
  end
end
