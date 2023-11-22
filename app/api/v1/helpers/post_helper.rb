module V1
  module Helpers
    class PostHelper
      def create_post(params, current_user)
        post = Post.new(caption: params[:caption], location: params[:location], user_id: current_user.id)
        if post.save
          tagged_users_ids = params[:tagged_users]
          tagged_users_ids&.each do |user_id|
            Tag.create(user_id: user_id, post_id: post.id)
          end
          { message: 'Post created successfully' }
        else
          raise AuthHelper::AuthenticationError.new('Failed to create post', 422)
        end
      end

      def get_user_posts(current_user)
        # current_user.posts.where(deleted_at: nil)
        Post.where(user_id: current_user.id, deleted_at: nil)
            .select(
              'posts.*',
              'COUNT(DISTINCT likes.id) AS like_count',
              "JSON_AGG(DISTINCT json_build_object('id', users.id, 'name', users.name)::text) AS tagged_users"
            )
            .joins('LEFT JOIN likes ON likes.post_id = posts.id')
            .joins('LEFT JOIN tags ON tags.post_id = posts.id')
            .joins('LEFT JOIN users ON tags.user_id = users.id')
            .group('posts.id')
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

      def delete_post(params)
        Post.update(params[:id], deleted_at: Time.now)
        { message: 'Post deleted successfully' }
      end

      def like_post(params, current_user)
        like = Like.where(user_id: current_user.id, post_id: params[:id])
        if like.length.positive?
          raise AuthHelper::AuthenticationError.new('like already exist for this user', 409)
        end
        Like.create(user_id: current_user.id, post_id: params[:id])
        { message: 'successfully liked the post' }
      end

      def get_liked_user(params)
        User.joins(:likes).where(likes: { post_id: params[:id] }).select('users.id, users.name')
      end
    end
  end
end