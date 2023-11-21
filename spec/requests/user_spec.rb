require 'rails_helper'

RSpec.describe V1::UserApi do
  include Rack::Test::Methods

  def app
    V1::UserApi
  end

  describe 'GET /api/v1/user' do
    it 'should fail to get all the users without login' do
      get '/api/v1/user'
      expect(last_response.status).to eq(403)
    end
  end
end