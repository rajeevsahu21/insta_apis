module V1
  class PostApi < Grape::API
    version 'v1'
    format :json
    AUTH_HELPER = Helpers::AuthHelper
    post_helper = Helpers::PostHelper.new

    rescue_from AUTH_HELPER::AuthenticationError do |e|
      error!({ error: e.message }, e.status)
    end

    resource :post do
      desc 'Create a post for user'
      params do
        requires :caption, type: String, desc: 'Caption of the post'
        requires :location, type: String, desc: 'Location of the post'
      end
      post do
        current_user = AUTH_HELPER.new(cookies).current_user
        post_helper.create(params, current_user)
      end
    end
  end
end