require 'rails_helper'

RSpec.describe V1::Auth do
  include Rack::Test::Methods

  def app
    V1::Auth
  end

  describe 'POST /api/v1/auth/signup' do
    it 'registers a user successfully' do
      post '/api/v1/auth/signup', { name: 'John Doe', email: 'john@example.com', password: 'password123' }
      expect(last_response.status).to eq(201) # Assuming successful creation returns 201 status
      expect(JSON.parse(last_response.body)).to include('message' => 'account created successfully')
    end

    it 'returns an error for invalid user registration' do
      post '/api/v1/auth/signup', { name: '', email: 'john@example.com', password: 'password123' }
      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)).to include('error' => 'something went wrong')
    end
  end

  describe 'POST /api/v1/auth/login' do
    it 'logs in a user successfully' do
      User.create(name: 'John Doe', email: 'john@example.com', password: 'password123')
      post '/api/v1/auth/login', { email: 'john@example.com', password: 'password123' }
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to include('message' => 'user logged in successfully')
    end

    it 'returns an error for invalid login credentials' do
      post '/api/v1/auth/login', { email: 'john@example.com', password: 'invalid_password' }
      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)).to include('error' => 'Email or password is invalid')
    end
  end

  describe 'POST /api/v1/auth/logout' do
    it 'logs out a logged-in user successfully' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password123')
      post '/api/v1/auth/login', { email: 'john@example.com', password: 'password123' }
      post '/api/v1/auth/logout', {}, 'rack.session' => { user_id: user.id }
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to include('message' => 'User logout successfully')
    end

    it 'returns an error when trying to log out without being logged in' do
      post '/api/v1/auth/logout'
      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)).to include('error' => 'user is not logged in')
    end
  end
end
