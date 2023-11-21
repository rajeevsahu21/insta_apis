module V1
  module Helpers
    class PostHelper
      def create(params, current_user)
        post = Post.new(caption: params[:caption], location: params[:location], user_id: current_user.id)
        if post.save
          { message: 'Post created successfully' }
        else
          raise AuthHelper::AuthenticationError.new('Failed to create post', 422)
        end
      end
    end
  end
end