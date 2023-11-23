require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'belongs to a post' do
      expect(described_class.reflect_on_association(:post).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'requires a user' do
      like = build(:like, user: nil)
      expect(like).not_to be_valid
      expect(like.errors[:user]).to include("must exist")
    end

    it 'requires a post' do
      like = build(:like, post: nil)
      expect(like).not_to be_valid
      expect(like.errors[:post]).to include("must exist")
    end
    # You can add other validation checks as needed
  end

  describe 'factory' do
    it 'is valid' do
      like = build(:like)
      expect(like).to be_valid
    end
  end

  describe 'scopes' do
    describe '.for_user' do
      it 'returns likes for a specific user' do
        user = create(:user)
        post = create(:post)
        like1 = create(:like, user: user, post: post)
        like2 = create(:like, user: user, post: create(:post)) # Another post

        likes_for_user = Like.for_user(user.id)

        expect(likes_for_user).to include(like1)
        expect(likes_for_user).to include(like2)
      end
    end

    describe '.for_post' do
      it 'returns likes for a specific post' do
        post = create(:post)
        user1 = create(:user)
        user2 = create(:user)
        like1 = create(:like, user: user1, post: post)
        like2 = create(:like, user: user2, post: post)

        likes_for_post = Like.for_post(post.id)

        expect(likes_for_post).to include(like1)
        expect(likes_for_post).to include(like2)
      end
    end
  end
end
