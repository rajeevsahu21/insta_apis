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
        optional :tagged_user, type: Array[Integer], desc: 'Ids of tagged users'
      end
      post do
        current_user = AUTH_HELPER.new(cookies).current_user
        post_helper.create_post(params, current_user)
      end
      desc 'Get all post of the user'
      get do
        current_user = AUTH_HELPER.new(cookies).current_user
        post_helper.get_user_posts(current_user)
      end
      desc 'Update a post'
      params do
        optional :caption, type: String, desc: 'Caption of the post'
        optional :location, type: String, desc: 'Location of the post'
      end
      put ':id' do
        current_user = AUTH_HELPER.new(cookies).current_user
        post_helper.update_post(params, current_user)
      end
      desc 'Delete a post'
      delete ':id' do
        AUTH_HELPER.new(cookies).current_user
        post_helper.delete_post(params)
      end
      desc 'Like a post'
      params do
        requires :id, type: Integer, desc: 'Post Id'
      end
      post ':id/like' do
        current_user = AUTH_HELPER.new(cookies).current_user
        post_helper.like_post(params, current_user)
      end
      desc 'get likes of a post'
      params do
        requires :id, type: Integer, desc: 'Post Id'
      end
      get ':id/like' do
        AUTH_HELPER.new(cookies).current_user
        post_helper.get_liked_user(params)
      end
    end
  end
end