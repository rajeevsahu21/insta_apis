require 'rails_helper'

RSpec.describe V1::PostApi do
  include Rack::Test::Methods
  let(:user) { create(:user) }

  def app
    V1::PostApi
  end

  describe 'POST /api/v1/post' do
    it 'creates a post for the authenticated user' do
      set_cookie("user_id=#{user.id}")
      post '/api/v1/post', data: { caption: 'Test Caption', location: 'Test Location', tagged_users: [1, 2, 3] }.to_json

      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)['message']).to eq('Post created successfully')
    end

    it 'returns an error if data not present' do
      set_cookie("user_id=#{user.id}")
      # Simulate a failure scenario by not providing required parameters
      post '/api/v1/post'

      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)['error']).to eq('data is missing')
    end
  end

  describe 'GET /api/v1/post' do
    it 'returns a list of posts for the authenticated user' do
      set_cookie("user_id=#{user.id}")
      get '/api/v1/post'

      expect(last_response.status).to eq(200)
      # Add additional expectations based on the response format and data
    end
  end

  describe 'PUT /api/v1/post/:id' do
    let(:post) { create(:post, user: user) }

    it 'updates a post for the authenticated user' do
      set_cookie("user_id=#{user.id}")
      put "/api/v1/post/#{post.id}", caption: 'Updated Caption'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['caption']).to eq('Updated Caption')
    end
  end

  describe 'DELETE /api/v1/post/:id' do
    let(:post) { create(:post, user: user) }

    it 'deletes a post for the authenticated user' do
      set_cookie("user_id=#{user.id}")
      delete "/api/v1/post/#{post.id}"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['message']).to eq('Post deleted successfully')
    end
  end
end
