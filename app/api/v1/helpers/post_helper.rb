module V1
  module Helpers
    class PostHelper
      def create_post(params, current_user)
        post = Post.new(caption: params[:caption], location: params[:location], user_id: current_user.id)
        if post.save
          { message: 'Post created successfully' }
        else
          raise AuthHelper::AuthenticationError.new('Failed to create post', 422)
        end
      end

      def get_user_posts(current_user)
        current_user.posts
      end

      def update_post(params, current_user)
        if params[:caption]
          Post.update(params[:id], caption: params[:caption])
        end
        if params[:location]
          Post.update(params[:id], location: params[:location])
        end
        Post.find(params[:id])
      end

      def delete_post(params) end
    end
  end
end