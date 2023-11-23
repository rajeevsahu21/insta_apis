require 'rails_helper'

RSpec.describe Comment, type: :model do
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
      expect(build(:comment, user: nil)).not_to be_valid
    end

    it 'requires a post' do
      expect(build(:comment, post: nil)).not_to be_valid
    end

    it 'requires content' do
      expect(build(:comment, content: nil)).not_to be_valid
    end

    # You can add any other validations as needed
  end

  describe 'factory' do
    it 'is valid' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  describe 'scopes' do
    describe '.for_post' do
      it 'returns comments for a specific post' do
        post = create(:post)
        user1 = create(:user)
        user2 = create(:user)
        comment1 = create(:comment, user: user1, post: post)
        comment2 = create(:comment, user: user2, post: post)

        comments_for_post = Comment.for_post(post.id)

        expect(comments_for_post).to include(comment1)
        expect(comments_for_post).to include(comment2)
      end
    end
  end
end
