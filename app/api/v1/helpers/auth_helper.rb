module V1
  module Helpers
    class AuthHelper
      class AuthenticationError < StandardError
        attr_reader :status

        def initialize(message, status)
          super(message)
          @status = status
        end
      end

      def initialize(cookies)
        @cookies = cookies
      end

      def register_user(params)
        user = User.new(name: params[:name], email: params[:email], password: params[:password])
        if user.save
          @cookies[:user_id] = {
            value: user.id,
            path: '/api/v1'
          }
          { message: 'account created successfully' }
        else
          raise AuthenticationError.new('Failed to create account', 422)
        end
      end

      def login_user(params)
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          @cookies[:user_id] = {
            value: user.id,
            path: '/api/v1'
          }
          { message: 'user logged in successfully' }
        else
          raise AuthenticationError.new('Email or password is invalid', 401)
        end
      end

      def logout_user
        if @cookies[:user_id]
          @cookies.delete(:user_id)
          { message: 'User logout successfully' }
        else
          raise AuthenticationError.new('User is not logged in', 401)
        end
      end

      def current_user
        if (user_id = @cookies[:user_id])
          user = User.find_by(id: user_id)
          if user
            @current_user = user
          else
            raise AuthenticationError.new('User is not logged in', 401)
          end
        else
          raise AuthenticationError.new('Cookies not found', 403)
        end
      end
    end
  end
end
