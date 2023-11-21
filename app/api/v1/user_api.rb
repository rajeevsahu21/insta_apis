module V1
  class UserApi < Grape::API
    AUTH_HELPER = Helpers::AuthHelper
    user_helper = Helpers::UserHelper.new

    version 'v1'
    format :json

    rescue_from AUTH_HELPER::AuthenticationError do |e|
      error!({ error: e.message }, e.status)
    end

    resource :user do
      desc 'Get all the users'
      params do
        optional :page, type: Integer, default: 1
        optional :size, type: Integer, default: 15
      end
      get do
        AUTH_HELPER.new(cookies).current_user
        user_helper.get_all_users(params)
      end
    end
  end
end