require 'rails_helper'

RSpec.describe V1::UserApi do
  include Rack::Test::Methods
  let(:user) { create(:user) }

  def app
    V1::UserApi
  end

  describe 'GET /api/v1/user' do
    it 'should fail to get all the users without login' do
      get '/api/v1/user'
      expect(last_response.status).to eq(403)
    end
  end

  describe 'GET /api/v1/user' do
    it 'returns a list of users for the authenticated user' do
      set_cookie("user_id=#{user.id}")
      get '/api/v1/user', page: 1, size: 10

      expect(last_response.status).to eq(200)
      # Add additional expectations based on the response format and data
    end
  end

  describe 'POST /api/v1/user/follow' do
    let(:other_user) { create(:user) }

    it 'allows the authenticated user to follow another user' do
      set_cookie("user_id=#{user.id}")
      post '/api/v1/user/follow', followed_id: other_user.id

      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)['message']).to eq('follow success')
    end

    it 'returns an error if the user is already followed' do
      user.follow(other_user)
      set_cookie("user_id=#{user.id}")

      post '/api/v1/user/follow', followed_id: other_user.id

      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)['error']).to eq('user is already followed')
    end

    it 'returns an error if the followed user is not found' do
      set_cookie("user_id=#{user.id}")

      post '/api/v1/user/follow', followed_id: 9999 # Assuming 9999 is an invalid user id

      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)['error']).to eq('user is not found')
    end
  end

  describe 'POST /api/v1/user/unfollow' do
    let(:followed_user) { create(:user) }

    it 'allows the authenticated user to unfollow another user' do
      user.follow(followed_user)
      set_cookie("user_id=#{user.id}")

      post '/api/v1/user/unfollow', followed_id: followed_user.id

      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)['message']).to eq('unfollow success')
    end

    it 'returns an error if the user is not found in the followed list' do
      set_cookie("user_id=#{user.id}")

      post '/api/v1/user/unfollow', followed_id: followed_user.id

      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)['error']).to eq('user is not found in followed list')
    end
  end
end