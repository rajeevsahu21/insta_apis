require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'associations' do
    it 'belongs to a follower' do
      expect(described_class.reflect_on_association(:follower).macro).to eq :belongs_to
    end

    it 'belongs to a followed user' do
      expect(described_class.reflect_on_association(:followed).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'requires a follower_id' do
      expect(build(:relationship, follower_id: nil)).not_to be_valid
    end

    it 'requires a followed_id' do
      expect(build(:relationship, followed_id: nil)).not_to be_valid
    end
  end
end
