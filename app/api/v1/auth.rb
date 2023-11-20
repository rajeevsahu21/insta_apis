module V1
  class Auth < Grape::API
    AUTH_HELPER = Helpers::AuthHelper
    version 'v1'
    format :json

    rescue_from V1::Helpers::AuthHelper::AuthenticationError do |e|
      error!({ error: e.message }, e.status)
    end

    resources :auth do
      desc 'Register user'
      params do
        requires :name, type: String, desc: 'Name of the User'
        requires :email, type: String, desc: 'Email of the User'
        requires :password, type: String, desc: 'Password of the User'
      end
      post :signup do
        AUTH_HELPER.new(cookies).register_user(params)
      end
      desc 'Login user'
      params do
        requires :email, type: String, desc: 'Email of User'
        requires :password, type: String, desc: 'Password of the User'
      end
      post :login do
        AUTH_HELPER.new(cookies).login_user(params)
      end
      desc 'Logout User'
      post :logout do
        AUTH_HELPER.new(cookies).logout_user
      end
    end
  end
end
