require 'rails_helper'

RSpec.describe Tag, type: :model do
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
      expect(build(:tag, user: nil)).not_to be_valid
    end

    it 'requires a post' do
      expect(build(:tag, post: nil)).not_to be_valid
    end
  end

  describe 'factory' do
    it 'is valid' do
      tag = build(:tag)
      expect(tag).to be_valid
    end
  end
end
