module V1
  module Helpers
    class UserHelper
      def get_all_users(params)
        offset = params[:size] * (params[:page] - 1)
        User.order(id: :asc).limit(params[:size]).offset(offset).select(:id, :name, :email)
      end

      def follow_user(params, current_user)
        @user = User.find(params[:followed_id])
        if @user
          if current_user.following.include?(@user)
            raise AuthHelper::AuthenticationError.new('user is already followed', 400)
          end
          current_user.follow(@user)
          { message: 'follow success' }
        else
          raise AuthHelper::AuthenticationError.new('user is not found', 400)
        end
      end

      def unfollow_user(params, current_user)
        @user = User.find(params[:followed_id])
        if current_user.following.include?(@user)
          current_user.unfollow(@user)
          { message: 'unfollow success' }
        else
          raise AuthHelper::AuthenticationError.new('user is not found in followed list', 400)
        end
      end
    end
  end
end